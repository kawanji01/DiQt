import 'package:booqs_mobile/models/quiz.dart';

class AnswerAnalysis {
  AnswerAnalysis({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.drillId,
    required this.answerHistoriesCount,
    required this.incorrectAnswerHistoriesCount,
    this.lastAnswer,
    required this.correctAnswerRate,
    required this.lastAnsweredAt,
    required this.lastAnswerCorrect,
    required this.solvedAtDrill,
    required this.createdAt,
    required this.updatedAt,
    this.pronunciationIncorrectReasons = const [],
    this.pronunciationWordAssessmentRows = const [],
    this.pronunciationPhonemeComparisonRows = const [],
    this.pronunciationReferenceHighlightSegments = const [],
    this.pronunciationWordHighlights = const [],
    this.pronunciationConnectedSpeechFeedbacks = const [],
    this.lastPronunciationPayload,
    this.quiz,
  });

  int id;
  int userId;
  int quizId;
  int drillId;
  int answerHistoriesCount;
  int incorrectAnswerHistoriesCount;
  String? lastAnswer;
  double correctAnswerRate;
  DateTime lastAnsweredAt;
  bool lastAnswerCorrect;
  bool solvedAtDrill;
  DateTime createdAt;
  DateTime updatedAt;
  List<Map<String, dynamic>> pronunciationIncorrectReasons;
  List<Map<String, dynamic>> pronunciationWordAssessmentRows;
  List<Map<String, dynamic>> pronunciationPhonemeComparisonRows;
  List<Map<String, dynamic>> pronunciationReferenceHighlightSegments;
  List<Map<String, dynamic>> pronunciationWordHighlights;
  List<Map<String, dynamic>> pronunciationConnectedSpeechFeedbacks;
  Map<String, dynamic>? lastPronunciationPayload;
  Quiz? quiz;

  AnswerAnalysis.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        quizId = json['quiz_id'],
        drillId = json['drill_id'],
        answerHistoriesCount = json['answer_histories_count'],
        incorrectAnswerHistoriesCount =
            json['incorrect_answer_histories_count'],
        correctAnswerRate = (json['correct_answer_rate'] as num).toDouble(),
        lastAnswer = json['last_answer'],
        lastAnsweredAt = DateTime.parse(json['last_answered_at']),
        lastAnswerCorrect = json['last_answer_correct'],
        solvedAtDrill = json['solved_at_drill'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        pronunciationIncorrectReasons =
            AnswerAnalysis._mapList(json['pronunciation_incorrect_reasons']),
        pronunciationWordAssessmentRows =
            AnswerAnalysis._mapList(json['pronunciation_word_assessment_rows']),
        pronunciationPhonemeComparisonRows = AnswerAnalysis._mapList(
            json['pronunciation_phoneme_comparison_rows']),
        pronunciationReferenceHighlightSegments = AnswerAnalysis._mapList(
            json['pronunciation_reference_highlight_segments']),
        pronunciationWordHighlights =
            AnswerAnalysis._mapList(json['pronunciation_word_highlights']),
        pronunciationConnectedSpeechFeedbacks = AnswerAnalysis._mapList(
            json['pronunciation_connected_speech_feedbacks']),
        lastPronunciationPayload =
            AnswerAnalysis._mapOrNull(json['last_pronunciation_payload']),
        quiz = json['quiz'] == null ? null : Quiz.fromJson(json['quiz']);

  static List<Map<String, dynamic>> _mapList(dynamic value) {
    if (value is! List) return [];

    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  static Map<String, dynamic>? _mapOrNull(dynamic value) {
    if (value is! Map) return null;

    return Map<String, dynamic>.from(value);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'quiz_id': quizId,
        'drill_id': drillId,
        'answer_histories_count': answerHistoriesCount,
        'incorrect_answer_histories_count': incorrectAnswerHistoriesCount,
        'correct_answer_rate': correctAnswerRate,
        'last_answer': lastAnswer,
        'last_answered_at': lastAnsweredAt,
        'last_answer_correct': lastAnswerCorrect,
        'solved_at_drill': solvedAtDrill,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'pronunciation_incorrect_reasons': pronunciationIncorrectReasons,
        'pronunciation_word_assessment_rows': pronunciationWordAssessmentRows,
        'pronunciation_phoneme_comparison_rows':
            pronunciationPhonemeComparisonRows,
        'pronunciation_reference_highlight_segments':
            pronunciationReferenceHighlightSegments,
        'pronunciation_word_highlights': pronunciationWordHighlights,
        'pronunciation_connected_speech_feedbacks':
            pronunciationConnectedSpeechFeedbacks,
        'last_pronunciation_payload': lastPronunciationPayload,
        'quiz': quiz,
      };
}
