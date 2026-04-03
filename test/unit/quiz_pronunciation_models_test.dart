import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pronunciation models', () {
    test('Quiz.fromJson parses speech answer settings', () {
      final Quiz quiz = Quiz.fromJson({
        'id': 1,
        'drill_id': 1,
        'applied_dictionary_id': 1,
        'question': 'question',
        'lang_number_of_question': 44,
        'question_read_aloud': false,
        'correct_answer': 'spoken answer',
        'lang_number_of_answer': 21,
        'answer_read_aloud': false,
        'short_answer_enabled': true,
        'answer_mode': 'speech',
        'pronunciation_accuracy_threshold': 91,
        'pronunciation_completeness_threshold': 87,
        'question_hidden': false,
        'auto_dict_link_of_question': false,
        'auto_dict_link_of_answer': false,
        'accepted_quiz_requests_count': 0,
        'pending_quiz_requests_count': 0,
        'quiz_requests_count': 0,
      });

      expect(quiz.answerMode, 'speech');
      expect(quiz.pronunciationAccuracyThreshold, 91);
      expect(quiz.pronunciationCompletenessThreshold, 87);
    });

    test('Quiz resolves an explicit pronunciation locale as-is', () {
      final Quiz quiz = Quiz.fromJson({
        'id': 1,
        'drill_id': 1,
        'applied_dictionary_id': 1,
        'question': 'question',
        'lang_number_of_question': 44,
        'question_read_aloud': false,
        'correct_answer': 'spoken answer',
        'lang_number_of_answer': languageCodeMap['en'],
        'answer_read_aloud': false,
        'short_answer_enabled': true,
        'answer_mode': 'speech',
        'effective_pronunciation_assessment_locale': 'en-GB',
        'question_hidden': false,
        'auto_dict_link_of_question': false,
        'auto_dict_link_of_answer': false,
        'accepted_quiz_requests_count': 0,
        'pending_quiz_requests_count': 0,
        'quiz_requests_count': 0,
      });

      expect(quiz.resolvedPronunciationAssessmentLocale, 'en-GB');
    });

    test('Quiz falls back to the legacy English and Japanese locales', () {
      final Quiz englishQuiz = Quiz.fromJson({
        'id': 1,
        'drill_id': 1,
        'applied_dictionary_id': 1,
        'question': 'question',
        'lang_number_of_question': 44,
        'question_read_aloud': false,
        'correct_answer': 'spoken answer',
        'lang_number_of_answer': languageCodeMap['en'],
        'answer_read_aloud': false,
        'short_answer_enabled': true,
        'answer_mode': 'speech',
        'question_hidden': false,
        'auto_dict_link_of_question': false,
        'auto_dict_link_of_answer': false,
        'accepted_quiz_requests_count': 0,
        'pending_quiz_requests_count': 0,
        'quiz_requests_count': 0,
      });
      final Quiz japaneseQuiz = Quiz.fromJson({
        'id': 2,
        'drill_id': 1,
        'applied_dictionary_id': 1,
        'question': 'question',
        'lang_number_of_question': 44,
        'question_read_aloud': false,
        'correct_answer': 'spoken answer',
        'lang_number_of_answer': languageCodeMap['ja'],
        'answer_read_aloud': false,
        'short_answer_enabled': true,
        'answer_mode': 'speech',
        'question_hidden': false,
        'auto_dict_link_of_question': false,
        'auto_dict_link_of_answer': false,
        'accepted_quiz_requests_count': 0,
        'pending_quiz_requests_count': 0,
        'quiz_requests_count': 0,
      });

      expect(englishQuiz.resolvedPronunciationAssessmentLocale, 'en-US');
      expect(japaneseQuiz.resolvedPronunciationAssessmentLocale, 'ja-JP');
    });

    test('Quiz keeps unsupported languages unresolved without API locale', () {
      final Quiz quiz = Quiz.fromJson({
        'id': 1,
        'drill_id': 1,
        'applied_dictionary_id': 1,
        'question': 'question',
        'lang_number_of_question': 44,
        'question_read_aloud': false,
        'correct_answer': 'spoken answer',
        'lang_number_of_answer': languageCodeMap['fr'],
        'answer_read_aloud': false,
        'short_answer_enabled': true,
        'answer_mode': 'speech',
        'question_hidden': false,
        'auto_dict_link_of_question': false,
        'auto_dict_link_of_answer': false,
        'accepted_quiz_requests_count': 0,
        'pending_quiz_requests_count': 0,
        'quiz_requests_count': 0,
      });

      expect(quiz.resolvedPronunciationAssessmentLocale, isNull);
    });

    test('AnswerAnalysis.fromJson parses pronunciation payloads', () {
      final AnswerAnalysis answerAnalysis = AnswerAnalysis.fromJson({
        'id': 1,
        'user_id': 1,
        'quiz_id': 1,
        'drill_id': 1,
        'answer_histories_count': 3,
        'incorrect_answer_histories_count': 2,
        'correct_answer_rate': 33.3,
        'last_answer': 'spoken answer',
        'last_answered_at': '2026-03-10T10:00:00Z',
        'last_answer_correct': false,
        'solved_at_drill': true,
        'created_at': '2026-03-10T10:00:00Z',
        'updated_at': '2026-03-10T10:00:00Z',
        'pronunciation_incorrect_reasons': [
          {
            'key': 'accuracy_low',
            'params': {'score': 70, 'threshold': 80}
          }
        ],
        'pronunciation_word_assessment_rows': [
          {'word': 'spoken', 'score': 70, 'issue': true}
        ],
        'pronunciation_phoneme_comparison_rows': [
          {
            'word': 'spoken',
            'expected_phoneme': 'oʊ',
            'actual_phoneme': 'ɔ',
            'score': 68,
            'mismatch': true
          }
        ],
        'pronunciation_reference_highlight_segments': [
          {'text': 'spo', 'issue': false},
          {'text': 'ken', 'issue': true}
        ],
        'pronunciation_word_highlights': [
          {
            'word': 'spoken',
            'segments': [
              {'text': 'spo', 'issue': false},
              {'text': 'ken', 'issue': true}
            ]
          }
        ],
        'pronunciation_connected_speech_feedbacks': [
          {
            'category': 'linking',
            'message_key': 'linking_general',
            'boundary_label': 'turn it'
          }
        ],
        'last_pronunciation_payload': {
          'recognized_text': 'spoken answer',
        },
      });

      expect(answerAnalysis.pronunciationIncorrectReasons, hasLength(1));
      expect(answerAnalysis.pronunciationWordAssessmentRows.first['word'],
          'spoken');
      expect(
          answerAnalysis.pronunciationPhonemeComparisonRows.first['mismatch'],
          true);
      expect(
          answerAnalysis.pronunciationReferenceHighlightSegments.last['issue'],
          true);
      expect(
          answerAnalysis
              .pronunciationConnectedSpeechFeedbacks.first['category'],
          'linking');
      expect(answerAnalysis.lastPronunciationPayload?['recognized_text'],
          'spoken answer');
    });
  });
}
