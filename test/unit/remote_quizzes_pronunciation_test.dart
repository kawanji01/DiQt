import 'dart:io';

import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/data/remote/azure_speech_assessment.dart';
import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter_test/flutter_test.dart';

class _ThrowingAssessmentClient extends AzureSpeechAssessmentClient {
  _ThrowingAssessmentClient(this.exception);

  final AzureSpeechAssessmentException exception;

  @override
  Future<Map<String, dynamic>> assessPronunciation({
    required File audioFile,
    required String locale,
    required String referenceText,
  }) async {
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

    test('returns the localized unavailable copy for unsupported locales',
        () async {
      final Map<dynamic, dynamic> resMap =
          await RemoteQuizzes.answerPronunciation(
        quiz: _buildSpeechQuiz(langNumberOfAnswer: languageCodeMap['fr']!),
        audioFile: audioFile,
      );

      expect(resMap['status'], 422);
      expect(resMap['message'], t.quizzes.pronunciation_unavailable);
    });
  });
}

Quiz _buildSpeechQuiz({int? langNumberOfAnswer}) {
  return Quiz(
    id: 1,
    drillId: 1,
    appliedDictionaryId: 1,
    question: 'question',
    langNumberOfQuestion: languageCodeMap['ja']!,
    questionReadAloud: false,
    correctAnswer: 'spoken answer',
    langNumberOfAnswer: langNumberOfAnswer ?? languageCodeMap['en']!,
    answerReadAloud: false,
    shortAnswerEnabled: true,
    answerMode: 'speech',
    questionHidden: false,
    autoDictLinkOfQuestion: false,
    autoDictLinkOfAnswer: false,
    acceptedQuizRequestsCount: 0,
    pendingQuizRequestsCount: 0,
    quizRequestsCount: 0,
  );
}
