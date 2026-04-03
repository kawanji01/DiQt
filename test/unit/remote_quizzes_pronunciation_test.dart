import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/data/remote/azure_speech_assessment.dart';
import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter_test/flutter_test.dart';

class _ThrowingAssessmentClient extends AzureSpeechAssessmentClient {
  _ThrowingAssessmentClient(this.exception, {this.onCall});

  final Object exception;
  final void Function(
    String locale,
    WavAudioInspectionResult? audioInspection,
  )? onCall;

  @override
  Future<Map<String, dynamic>> assessPronunciation({
    required File audioFile,
    required String locale,
    required String referenceText,
    WavAudioInspectionResult? audioInspection,
  }) async {
    onCall?.call(locale, audioInspection);
    throw exception;
  }
}

void main() {
  group('RemoteQuizzes.answerPronunciation', () {
    late File audioFile;

    setUp(() async {
      LocaleSettings.setLocaleSync(AppLocale.en);
      final Directory tempDir = await Directory.systemTemp.createTemp(
        'remote-quizzes-pronunciation-test',
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

    test('maps Azure no-match failures to the localized no-result copy',
        () async {
      final Map<dynamic, dynamic> resMap =
          await RemoteQuizzes.answerPronunciation(
        quiz: _buildSpeechQuiz(),
        audioFile: audioFile,
        assessmentClient: _ThrowingAssessmentClient(
          const AzureSpeechAssessmentException(
            422,
            'Azure pronunciation assessment returned no recognized speech.',
          ),
        ),
      );

      expect(resMap['status'], 422);
      expect(resMap['message'], t.quizzes.pronunciation_no_result);
    });

    test('maps token failures to a retryable unavailable response', () async {
      final Map<dynamic, dynamic> resMap =
          await RemoteQuizzes.answerPronunciation(
        quiz: _buildSpeechQuiz(),
        audioFile: audioFile,
        assessmentClient: _ThrowingAssessmentClient(
          const AzureSpeechAssessmentException(
            422,
            'Failed to fetch Azure Speech token',
          ),
        ),
      );

      expect(resMap['status'], 401);
      expect(resMap['message'], t.quizzes.pronunciation_unavailable);
    });

    test('maps Azure service failures to the localized unavailable copy',
        () async {
      final Map<dynamic, dynamic> resMap =
          await RemoteQuizzes.answerPronunciation(
        quiz: _buildSpeechQuiz(),
        audioFile: audioFile,
        assessmentClient: _ThrowingAssessmentClient(
          const AzureSpeechAssessmentException(
            503,
            'Azure service temporarily unavailable.',
          ),
        ),
      );

      expect(resMap['status'], 503);
      expect(resMap['message'], t.quizzes.pronunciation_unavailable);
    });

    test(
        'maps setup failures with non-auth 4xx to the localized unavailable copy',
        () async {
      final Map<dynamic, dynamic> resMap =
          await RemoteQuizzes.answerPronunciation(
        quiz: _buildSpeechQuiz(),
        audioFile: audioFile,
        assessmentClient: _ThrowingAssessmentClient(
          const AzureSpeechAssessmentException(
            404,
            'Azure Speech endpoint is not configured.',
          ),
        ),
      );

      expect(resMap['status'], 404);
      expect(resMap['message'], t.quizzes.pronunciation_unavailable);
    });

    test('returns the localized unavailable copy when locale data is missing',
        () async {
      final Map<dynamic, dynamic> resMap =
          await RemoteQuizzes.answerPronunciation(
        quiz: _buildSpeechQuiz(langNumberOfAnswer: languageCodeMap['fr']!),
        audioFile: audioFile,
      );

      expect(resMap['status'], 422);
      expect(resMap['message'], t.quizzes.pronunciation_unavailable);
    });

    test(
        'falls back to the legacy English and Japanese locales when the API field is absent',
        () async {
      final List<Map<String, dynamic>> testCases = <Map<String, dynamic>>[
        <String, dynamic>{
          'langNumber': languageCodeMap['en']!,
          'locale': 'en-US',
        },
        <String, dynamic>{
          'langNumber': languageCodeMap['ja']!,
          'locale': 'ja-JP',
        },
      ];

      for (final Map<String, dynamic> testCase in testCases) {
        String? capturedLocale;

        final Map<dynamic, dynamic> resMap =
            await RemoteQuizzes.answerPronunciation(
          quiz: _buildSpeechQuiz(
            langNumberOfAnswer: testCase['langNumber'] as int,
            backfillEffectivePronunciationAssessmentLocale: false,
          ),
          audioFile: audioFile,
          assessmentClient: _ThrowingAssessmentClient(
            const AzureSpeechAssessmentException(
              503,
              'Azure service temporarily unavailable.',
            ),
            onCall: (
              String locale,
              WavAudioInspectionResult? audioInspection,
            ) {
              capturedLocale = locale;
            },
          ),
        );

        expect(capturedLocale, testCase['locale']);
        expect(resMap['status'], 503);
        expect(resMap['message'], t.quizzes.pronunciation_unavailable);
      }
    });

    test('uses effective pronunciation locales for newly supported languages',
        () async {
      final List<Map<String, dynamic>> testCases = <Map<String, dynamic>>[
        <String, dynamic>{
          'langNumber': languageCodeMap['fr']!,
          'locale': 'fr-FR',
        },
        <String, dynamic>{
          'langNumber': languageCodeMap['pt']!,
          'locale': 'pt-BR',
        },
      ];

      for (final Map<String, dynamic> testCase in testCases) {
        String? capturedLocale;
        WavAudioInspectionResult? capturedInspection;

        final Map<dynamic, dynamic> resMap =
            await RemoteQuizzes.answerPronunciation(
          quiz: _buildSpeechQuiz(
            langNumberOfAnswer: testCase['langNumber'] as int,
            effectivePronunciationAssessmentLocale:
                testCase['locale'] as String,
          ),
          audioFile: audioFile,
          assessmentClient: _ThrowingAssessmentClient(
            const AzureSpeechAssessmentException(
              503,
              'Azure service temporarily unavailable.',
            ),
            onCall: (
              String locale,
              WavAudioInspectionResult? audioInspection,
            ) {
              capturedLocale = locale;
              capturedInspection = audioInspection;
            },
          ),
        );

        expect(capturedLocale, testCase['locale']);
        expect(capturedInspection?.isSupportedPcm, isTrue);
        expect(capturedInspection?.metadata?.sampleRate, 16000);
        expect(resMap['status'], 503);
        expect(resMap['message'], t.quizzes.pronunciation_unavailable);
      }
    });

    test('returns the existing timeout map without logging side effects',
        () async {
      final TimeoutException exception =
          TimeoutException('timed out waiting for Azure');

      final Map<dynamic, dynamic> resMap =
          await RemoteQuizzes.answerPronunciation(
        quiz: _buildSpeechQuiz(),
        audioFile: audioFile,
        assessmentClient: _ThrowingAssessmentClient(exception),
      );

      expect(resMap['status'], 408);
      expect(resMap['message'], '$exception');
    });

    test('returns the existing socket map without logging side effects',
        () async {
      const SocketException exception = SocketException('network down');

      final Map<dynamic, dynamic> resMap =
          await RemoteQuizzes.answerPronunciation(
        quiz: _buildSpeechQuiz(),
        audioFile: audioFile,
        assessmentClient: _ThrowingAssessmentClient(exception),
      );

      expect(resMap['status'], 504);
      expect(resMap['message'], '$exception');
    });
  });
}

Quiz _buildSpeechQuiz({
  int? langNumberOfAnswer,
  String? effectivePronunciationAssessmentLocale,
  bool backfillEffectivePronunciationAssessmentLocale = true,
}) {
  final int resolvedLangNumber = langNumberOfAnswer ?? languageCodeMap['en']!;
  String? resolvedLocale = effectivePronunciationAssessmentLocale;
  if (resolvedLocale == null &&
      backfillEffectivePronunciationAssessmentLocale) {
    if (resolvedLangNumber == languageCodeMap['en']) {
      resolvedLocale = 'en-US';
    } else if (resolvedLangNumber == languageCodeMap['ja']) {
      resolvedLocale = 'ja-JP';
    }
  }

  return Quiz(
    id: 1,
    drillId: 1,
    appliedDictionaryId: 1,
    question: 'question',
    langNumberOfQuestion: languageCodeMap['ja']!,
    questionReadAloud: false,
    correctAnswer: 'spoken answer',
    langNumberOfAnswer: resolvedLangNumber,
    answerReadAloud: false,
    shortAnswerEnabled: true,
    answerMode: 'speech',
    effectivePronunciationAssessmentLocale: resolvedLocale,
    questionHidden: false,
    autoDictLinkOfQuestion: false,
    autoDictLinkOfAnswer: false,
    acceptedQuizRequestsCount: 0,
    pendingQuizRequestsCount: 0,
    quizRequestsCount: 0,
  );
}

List<int> buildPcmWavBytes({
  required int sampleRate,
  int channels = 1,
  int bitsPerSample = 16,
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
  header.setUint16(20, 1, Endian.little);
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
