import 'dart:convert';
import 'dart:io';

import 'package:booqs_mobile/data/remote/azure_speech_assessment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('AzureSpeechAssessmentClient', () {
    late File audioFile;

    setUp(() async {
      final Directory tempDir = await Directory.systemTemp.createTemp(
        'azure-speech-assessment-test',
      );
      audioFile = File('${tempDir.path}/sample.wav');
      await audioFile.writeAsBytes(<int>[0x52, 0x49, 0x46, 0x46]);
    });

    tearDown(() async {
      if (await audioFile.exists()) {
        await audioFile.delete();
      }
      final Directory parentDir = audioFile.parent;
      if (await parentDir.exists()) {
        await parentDir.delete(recursive: true);
      }
    });

    test('reuses cached token and sends the pronunciation assessment header',
        () async {
      int tokenRequestCount = 0;
      int assessmentRequestCount = 0;
      late String pronunciationAssessmentHeader;

      final backendClient = MockClient((http.Request request) async {
        tokenRequestCount += 1;
        expect(request.url.toString(), 'https://example.com/token');
        return http.Response(
          jsonEncode(<String, dynamic>{
            'token': 'test-token',
            'region': 'japaneast',
            'expires_in': 600,
          }),
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });
      final azureClient = MockClient((http.Request request) async {
        assessmentRequestCount += 1;
        pronunciationAssessmentHeader =
            request.headers['pronunciation-assessment']!;
        expect(request.headers['authorization'], 'Bearer test-token');
        expect(request.bodyBytes, isNotEmpty);
        return http.Response(
          jsonEncode(<String, dynamic>{
            'RecognitionStatus': 'Success',
            'DisplayText': 'spoken answer',
            'NBest': <Map<String, dynamic>>[
              <String, dynamic>{'Display': 'spoken answer'},
            ],
          }),
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });

      final client = AzureSpeechAssessmentClient(
        backendClient: backendClient,
        azureClient: azureClient,
        tokenUrl: Uri.parse('https://example.com/token'),
        assessmentUrlBuilder: (String region, String locale) {
          return Uri.parse('https://example.com/assessment?language=$locale');
        },
        headersProvider: () async => <String, String>{
          'content-type': 'application/json',
        },
        now: () => DateTime(2026, 3, 12, 7),
      );

      await client.assessPronunciation(
        audioFile: audioFile,
        locale: 'en-US',
        referenceText: 'spoken answer',
      );
      await client.assessPronunciation(
        audioFile: audioFile,
        locale: 'en-US',
        referenceText: 'spoken answer',
      );

      expect(tokenRequestCount, 1);
      expect(assessmentRequestCount, 2);

      final Map<String, dynamic> decodedHeader = Map<String, dynamic>.from(
        jsonDecode(utf8.decode(base64Decode(pronunciationAssessmentHeader)))
            as Map,
      );
      expect(decodedHeader['ReferenceText'], 'spoken answer');
      expect(decodedHeader['PhonemeAlphabet'], 'IPA');
      expect(decodedHeader['EnableProsodyAssessment'], true);
      expect(decodedHeader['NBestPhonemeCount'], 3);
    });

    test('refreshes the cached token when the auth session changes', () async {
      int tokenRequestCount = 0;
      String authToken = 'user-token-a';

      final backendClient = MockClient((http.Request request) async {
        tokenRequestCount += 1;
        final String? sessionToken = request.headers['X-User-Token'];
        return http.Response(
          jsonEncode(<String, dynamic>{
            'token': 'azure-$sessionToken',
            'region': 'japaneast',
            'expires_in': 600,
          }),
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });
      final azureClient = MockClient((http.Request request) async {
        expect(request.headers['authorization'], 'Bearer azure-$authToken');
        return http.Response(
          jsonEncode(<String, dynamic>{
            'RecognitionStatus': 'Success',
            'DisplayText': 'spoken answer',
            'NBest': <Map<String, dynamic>>[
              <String, dynamic>{'Display': 'spoken answer'},
            ],
          }),
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });

      final client = AzureSpeechAssessmentClient(
        backendClient: backendClient,
        azureClient: azureClient,
        tokenUrl: Uri.parse('https://example.com/token'),
        assessmentUrlBuilder: (String region, String locale) {
          return Uri.parse('https://example.com/assessment?language=$locale');
        },
        headersProvider: () async => <String, String>{
          'content-type': 'application/json',
          'X-User-Token': authToken,
        },
        now: () => DateTime(2026, 3, 12, 7),
      );

      await client.assessPronunciation(
        audioFile: audioFile,
        locale: 'en-US',
        referenceText: 'spoken answer',
      );

      authToken = 'user-token-b';

      await client.assessPronunciation(
        audioFile: audioFile,
        locale: 'en-US',
        referenceText: 'spoken answer',
      );

      expect(tokenRequestCount, 2);
    });

    test('throws 422 when Azure returns no recognized speech', () async {
      final backendClient = MockClient((http.Request request) async {
        return http.Response(
          jsonEncode(<String, dynamic>{
            'token': 'test-token',
            'region': 'japaneast',
            'expires_in': 600,
          }),
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });
      final azureClient = MockClient((http.Request request) async {
        return http.Response(
          jsonEncode(<String, dynamic>{
            'RecognitionStatus': 'NoMatch',
          }),
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });
      final client = AzureSpeechAssessmentClient(
        backendClient: backendClient,
        azureClient: azureClient,
        tokenUrl: Uri.parse('https://example.com/token'),
        assessmentUrlBuilder: (String region, String locale) {
          return Uri.parse('https://example.com/assessment?language=$locale');
        },
        headersProvider: () async => <String, String>{
          'content-type': 'application/json',
        },
      );

      await expectLater(
        () => client.assessPronunciation(
          audioFile: audioFile,
          locale: 'ja-JP',
          referenceText: 'spoken answer',
        ),
        throwsA(
          isA<AzureSpeechAssessmentException>().having(
              (AzureSpeechAssessmentException e) => e.status, 'status', 422),
        ),
      );
    });

    test('refreshes the token and retries once when Azure rejects auth',
        () async {
      int tokenRequestCount = 0;
      int assessmentRequestCount = 0;

      final backendClient = MockClient((http.Request request) async {
        tokenRequestCount += 1;
        if (tokenRequestCount == 1) {
          expect(request.url.queryParameters['force_refresh'], isNull);
          return http.Response(
            jsonEncode(<String, dynamic>{
              'token': 'stale-token',
              'region': 'japaneast',
              'expires_in': 600,
            }),
            200,
            headers: <String, String>{'content-type': 'application/json'},
          );
        }

        expect(request.url.queryParameters['force_refresh'], 'true');
        return http.Response(
          jsonEncode(<String, dynamic>{
            'token': 'fresh-token',
            'region': 'japaneast',
            'expires_in': 600,
          }),
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });
      final azureClient = MockClient((http.Request request) async {
        assessmentRequestCount += 1;
        if (assessmentRequestCount == 1) {
          expect(request.headers['authorization'], 'Bearer stale-token');
          return http.Response('Unauthorized', 401);
        }

        expect(request.headers['authorization'], 'Bearer fresh-token');
        return http.Response(
          jsonEncode(<String, dynamic>{
            'RecognitionStatus': 'Success',
            'DisplayText': 'spoken answer',
            'NBest': <Map<String, dynamic>>[
              <String, dynamic>{'Display': 'spoken answer'},
            ],
          }),
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });
      final client = AzureSpeechAssessmentClient(
        backendClient: backendClient,
        azureClient: azureClient,
        tokenUrl: Uri.parse('https://example.com/token'),
        assessmentUrlBuilder: (String region, String locale) {
          return Uri.parse('https://example.com/assessment?language=$locale');
        },
        headersProvider: () async => <String, String>{
          'content-type': 'application/json',
        },
      );

      final Map<String, dynamic> response = await client.assessPronunciation(
        audioFile: audioFile,
        locale: 'ja-JP',
        referenceText: 'spoken answer',
      );

      expect(tokenRequestCount, 2);
      expect(assessmentRequestCount, 2);
      expect(response['assessmentReferenceText'], 'spoken answer');
    });
  });
}
