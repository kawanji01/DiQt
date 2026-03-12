import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart' as http;

class AzureSpeechAssessmentException implements Exception {
  const AzureSpeechAssessmentException(this.status, this.message);

  final int status;
  final String message;

  @override
  String toString() => message;
}

class AzureSpeechAssessmentClient {
  AzureSpeechAssessmentClient({
    http.Client? backendClient,
    http.Client? azureClient,
    DateTime Function()? now,
    Uri? tokenUrl,
    Uri Function(String region, String locale)? assessmentUrlBuilder,
    Future<Map<String, String>> Function()? headersProvider,
  })  : _backendClient = backendClient ?? http.Client(),
        _azureClient = azureClient ?? http.Client(),
        _now = now ?? DateTime.now,
        _tokenUrl = tokenUrl,
        _assessmentUrlBuilder = assessmentUrlBuilder,
        _headersProvider = headersProvider;

  static const String _contentType =
      'audio/wav; codecs=audio/pcm; samplerate=16000';
  static const Duration _requestTimeout = Duration(seconds: 20);
  static const Duration _tokenRefreshBuffer = Duration(seconds: 30);
  static const int _defaultTokenLifetimeSeconds = 600;
  static const int _nBestPhonemeCount = 3;

  final http.Client _backendClient;
  final http.Client _azureClient;
  final DateTime Function() _now;
  final Uri? _tokenUrl;
  final Uri Function(String region, String locale)? _assessmentUrlBuilder;
  final Future<Map<String, String>> Function()? _headersProvider;

  _AzureSpeechToken? _tokenCache;

  Future<Map<String, dynamic>> assessPronunciation({
    required File audioFile,
    required String locale,
    required String referenceText,
  }) async {
    final String normalizedReferenceText = referenceText.trim();
    if (normalizedReferenceText.isEmpty) {
      throw const AzureSpeechAssessmentException(
        422,
        'Pronunciation reference text is missing.',
      );
    }

    final List<int> audioBytes = await audioFile.readAsBytes();
    final http.Response res = await _postAssessmentWithTokenRetry(
      audioBytes: audioBytes,
      locale: locale,
      referenceText: normalizedReferenceText,
    );

    final Map<String, dynamic> parsedResponse = _parseAssessmentResponse(res);
    return <String, dynamic>{
      'assessmentReferenceText': normalizedReferenceText,
      'raw': parsedResponse,
    };
  }

  Future<http.Response> _postAssessmentWithTokenRetry({
    required List<int> audioBytes,
    required String locale,
    required String referenceText,
  }) async {
    _AzureSpeechToken token = await _fetchToken();
    http.Response res = await _postAssessment(
      token: token,
      audioBytes: audioBytes,
      locale: locale,
      referenceText: referenceText,
    );
    if (_isAzureTokenRejected(res.statusCode)) {
      token = await _fetchToken(forceRefresh: true);
      res = await _postAssessment(
        token: token,
        audioBytes: audioBytes,
        locale: locale,
        referenceText: referenceText,
      );
    }
    return res;
  }

  Future<http.Response> _postAssessment({
    required _AzureSpeechToken token,
    required List<int> audioBytes,
    required String locale,
    required String referenceText,
  }) {
    final Uri url = _assessmentUrlBuilder?.call(token.region, locale) ??
        Uri.https(
          '${token.region}.stt.speech.microsoft.com',
          '/speech/recognition/conversation/cognitiveservices/v1',
          <String, String>{
            'language': locale,
            'format': 'detailed',
          },
        );

    return _azureClient
        .post(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': _contentType,
        'Authorization': 'Bearer ${token.token}',
        'Pronunciation-Assessment': _buildPronunciationAssessmentHeader(
          locale: locale,
          referenceText: referenceText,
        ),
      },
      body: audioBytes,
    )
        .timeout(_requestTimeout, onTimeout: () {
      throw TimeoutException('The connection has timed out!');
    });
  }

  bool _isAzureTokenRejected(int statusCode) {
    return statusCode == 401 || statusCode == 403;
  }

  Future<_AzureSpeechToken> _fetchToken({bool forceRefresh = false}) async {
    final DateTime now = _now();
    final Map<String, String> headers =
        await (_headersProvider?.call() ?? HttpService.headers());
    final String sessionToken = headers['X-User-Token'] ?? '';
    final _AzureSpeechToken? cachedToken = _tokenCache;
    if (!forceRefresh &&
        cachedToken != null &&
        cachedToken.sessionToken == sessionToken &&
        cachedToken.expiresAt.isAfter(now.add(_tokenRefreshBuffer))) {
      return cachedToken;
    }

    if (forceRefresh) {
      _tokenCache = null;
    }

    final Uri url = _buildTokenUrl(forceRefresh: forceRefresh);
    final http.Response res = await _backendClient
        .post(url, headers: headers)
        .timeout(_requestTimeout, onTimeout: () {
      throw TimeoutException('The connection has timed out!');
    });

    if (res.statusCode != 200) {
      throw _exceptionFromResponse(res);
    }

    final dynamic decoded = json.decode(res.body);
    if (decoded is! Map<String, dynamic>) {
      throw const AzureSpeechAssessmentException(
        500,
        'Failed to parse Azure Speech token response.',
      );
    }

    final String? token = decoded['token'] as String?;
    final String? region = decoded['region'] as String?;
    final int expiresIn = _parseExpiresIn(decoded['expires_in']);
    if (token == null || token.isEmpty || region == null || region.isEmpty) {
      throw const AzureSpeechAssessmentException(
        500,
        'Failed to parse Azure Speech token response.',
      );
    }

    final _AzureSpeechToken nextToken = _AzureSpeechToken(
      token: token,
      region: region,
      expiresAt: now.add(Duration(seconds: expiresIn)),
      sessionToken: sessionToken,
    );
    _tokenCache = nextToken;
    return nextToken;
  }

  Uri _buildTokenUrl({required bool forceRefresh}) {
    final Uri baseUrl = _tokenUrl ??
        Uri.parse('${DiQtURL.root()}/api/v1/mobile/azure_speech/token');
    if (!forceRefresh) return baseUrl;

    final Map<String, String> queryParameters =
        Map<String, String>.from(baseUrl.queryParameters);
    queryParameters['force_refresh'] = 'true';
    return baseUrl.replace(queryParameters: queryParameters);
  }

  int _parseExpiresIn(dynamic rawExpiresIn) {
    if (rawExpiresIn is int && rawExpiresIn > 0) return rawExpiresIn;
    if (rawExpiresIn is String) {
      final int? parsed = int.tryParse(rawExpiresIn);
      if (parsed != null && parsed > 0) return parsed;
    }
    return _defaultTokenLifetimeSeconds;
  }

  AzureSpeechAssessmentException _exceptionFromResponse(http.Response res) {
    try {
      final dynamic decoded = json.decode(res.body);
      if (decoded is Map<String, dynamic>) {
        final String? message = decoded['message'] as String?;
        if (message != null && message.isNotEmpty) {
          return AzureSpeechAssessmentException(res.statusCode, message);
        }
      }
    } catch (_) {
      // Ignore JSON parse failures and fall back to the response body.
    }

    final String message = res.body.isEmpty
        ? 'Request failed with status ${res.statusCode}.'
        : res.body;
    return AzureSpeechAssessmentException(res.statusCode, message);
  }

  Map<String, dynamic> _parseAssessmentResponse(http.Response res) {
    if (res.statusCode != 200) {
      throw _exceptionFromResponse(res);
    }

    final dynamic decoded = json.decode(res.body);
    if (decoded is! Map<String, dynamic>) {
      throw const AzureSpeechAssessmentException(
        422,
        'Azure pronunciation assessment returned invalid JSON.',
      );
    }

    final String recognitionStatus =
        (decoded['RecognitionStatus'] as String? ?? '').trim();
    if (recognitionStatus.isNotEmpty && recognitionStatus != 'Success') {
      throw AzureSpeechAssessmentException(
        422,
        'Azure pronunciation assessment returned no recognized speech: recognition_status=$recognitionStatus',
      );
    }

    final String displayText = (decoded['DisplayText'] as String? ?? '').trim();
    final List<dynamic> nbest =
        decoded['NBest'] as List<dynamic>? ?? const <dynamic>[];
    final Map<String, dynamic>? firstBest =
        nbest.isNotEmpty && nbest.first is Map<String, dynamic>
            ? nbest.first as Map<String, dynamic>
            : null;
    final String bestDisplay = (firstBest?['Display'] as String? ?? '').trim();
    if (displayText.isEmpty && bestDisplay.isEmpty) {
      throw const AzureSpeechAssessmentException(
        422,
        'Azure pronunciation assessment returned no recognized speech.',
      );
    }

    return decoded;
  }

  String _buildPronunciationAssessmentHeader({
    required String locale,
    required String referenceText,
  }) {
    final Map<String, dynamic> payload = <String, dynamic>{
      'ReferenceText': referenceText,
      'GradingSystem': 'HundredMark',
      'Granularity': 'Phoneme',
      'EnableMiscue': true,
      if (locale == 'en-US') ...<String, dynamic>{
        'Dimension': 'Comprehensive',
        'PhonemeAlphabet': 'IPA',
        'NBestPhonemeCount': _nBestPhonemeCount,
        'EnableProsodyAssessment': true,
      },
    };
    return base64Encode(utf8.encode(json.encode(payload)));
  }
}

class _AzureSpeechToken {
  const _AzureSpeechToken({
    required this.token,
    required this.region,
    required this.expiresAt,
    required this.sessionToken,
  });

  final String token;
  final String region;
  final DateTime expiresAt;
  final String sessionToken;
}
