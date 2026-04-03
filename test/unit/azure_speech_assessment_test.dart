import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
      await audioFile.writeAsBytes(buildPcmWavBytes(sampleRate: 16000));
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
      late String contentType;

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
        contentType = request.headers['content-type']!;
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
      expect(
        contentType,
        'audio/wav; codecs=audio/pcm; samplerate=16000',
      );

      final Map<String, dynamic> decodedHeader = Map<String, dynamic>.from(
        jsonDecode(utf8.decode(base64Decode(pronunciationAssessmentHeader)))
            as Map,
      );
      expect(decodedHeader['ReferenceText'], 'spoken answer');
      expect(decodedHeader['PhonemeAlphabet'], 'IPA');
      expect(decodedHeader['EnableProsodyAssessment'], true);
      expect(decodedHeader['NBestPhonemeCount'], 3);
    });

    test('keeps the Azure WAV content type fixed for non-16k PCM input',
        () async {
      await audioFile.writeAsBytes(buildPcmWavBytes(sampleRate: 48000));

      late String contentType;
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
        contentType = request.headers['content-type']!;
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

      await client.assessPronunciation(
        audioFile: audioFile,
        locale: 'en-US',
        referenceText: 'spoken answer',
      );

      expect(contentType, 'audio/wav; codecs=audio/pcm; samplerate=16000');
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

  group('WavAudioInspectionResult', () {
    test('parses common PCM WAV sample rates without changing metadata', () {
      for (final int sampleRate in <int>[16000, 44100, 48000]) {
        final WavAudioInspectionResult inspection =
            WavAudioInspectionResult.inspectBytes(
          buildPcmWavBytes(sampleRate: sampleRate),
        );

        expect(inspection.isSupportedPcm, isTrue);
        expect(inspection.metadata?.sampleRate, sampleRate);
        expect(inspection.metadata?.channels, 1);
      }
    });

    test('marks non-PCM WAV files as unsupported', () {
      final WavAudioInspectionResult inspection =
          WavAudioInspectionResult.inspectBytes(
        buildPcmWavBytes(sampleRate: 16000, audioFormat: 3),
      );

      expect(inspection.isSupportedPcm, isFalse);
      expect(inspection.metadata?.audioFormat, 3);
      expect(
        inspection.failureReason,
        'Pronunciation audio must use PCM WAV encoding.',
      );
    });
  });
}

List<int> buildPcmWavBytes({
  required int sampleRate,
  int channels = 1,
  int bitsPerSample = 16,
  int audioFormat = 1,
  int sampleCount = 160,
}) {
  final int bytesPerSample = bitsPerSample ~/ 8;
  final int dataSize = sampleCount * channels * bytesPerSample;
  final int byteRate = sampleRate * channels * bytesPerSample;
  final int blockAlign = channels * bytesPerSample;
  final ByteData header = ByteData(44);

  void writeAscii(int offset, String value) {
    for (int index = 0; index < value.length; index += 1) {
      header.setUint8(offset + index, value.codeUnitAt(index));
    }
  }

  writeAscii(0, 'RIFF');
  header.setUint32(4, 36 + dataSize, Endian.little);
  writeAscii(8, 'WAVE');
  writeAscii(12, 'fmt ');
  header.setUint32(16, 16, Endian.little);
  header.setUint16(20, audioFormat, Endian.little);
  header.setUint16(22, channels, Endian.little);
  header.setUint32(24, sampleRate, Endian.little);
  header.setUint32(28, byteRate, Endian.little);
  header.setUint16(32, blockAlign, Endian.little);
  header.setUint16(34, bitsPerSample, Endian.little);
  writeAscii(36, 'data');
  header.setUint32(40, dataSize, Endian.little);

  return <int>[
    ...header.buffer.asUint8List(),
    ...List<int>.filled(dataSize, 0),
  ];
}
