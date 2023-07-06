import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/user.dart';

class QuizRequest {
  QuizRequest({
    required this.id,
    required this.dictionaryId,
    required this.quizId,
    required this.userId,
    required this.question,
    required this.previousQuestion,
    required this.correctAnswer,
    required this.previousCorrectAnswer,
    required this.explanation,
    required this.previousExplanation,
    required this.addition,
    required this.modification,
    required this.elimination,
    required this.acceptance,
    required this.rejection,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.sentence,
    this.dictionary,
  });

  int id;
  int dictionaryId;
  int? quizId;
  int? userId;
  String? question;
  String? previousQuestion;
  String? correctAnswer;
  String? previousCorrectAnswer;
  String? explanation;
  String? previousExplanation;
  bool addition;
  bool modification;
  bool elimination;
  bool acceptance;
  bool rejection;
  DateTime createdAt;
  DateTime updatedAt;
  Dictionary? dictionary;
  Sentence? sentence;
  User? user;

  QuizRequest.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        quizId = json['quiz_id'],
        userId = json['user_id'],
        question = json['question'],
        previousQuestion = json['previous_question'],
        correctAnswer = json['correct_answer'],
        previousCorrectAnswer = json['previous_correct_answer'],
        explanation = json['explanation'],
        previousExplanation = json['previous_explanation'],
        addition = json['addition'],
        modification = json['modification'],
        elimination = json['elimination'],
        acceptance = json['acceptance'],
        rejection = json['rejection'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        sentence = json['sentence'] != null
            ? Sentence.fromJson(json['sentence'])
            : null,
        dictionary = json['dictionary'] != null
            ? Dictionary.fromJson(json['dictionary'])
            : null;

  bool isPending() => acceptance == false && rejection == false;

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'quiz_id': quizId,
        'user_id': userId,
        'question': question,
        'previous_question': previousQuestion,
        'correct_answer': correctAnswer,
        'previous_correct_answer': previousCorrectAnswer,
        'explanation': explanation,
        'previous_explanation': previousExplanation,
        'addition': addition,
        'modification': modification,
        'elimination': elimination,
        'acceptance': acceptance,
        'rejection': rejection,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'user': user?.toJson(),
        'sentence': sentence?.toJson(),
        'dictionary': dictionary?.toJson(),
      };
}
