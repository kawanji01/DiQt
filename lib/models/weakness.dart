import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';

class Weakness {
  Weakness({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.solved,
    required this.incorrectAnswersCount,
    required this.answersCount,
    required this.correctAnswerRate,
    required this.createdAt,
    required this.updatedAt,
    this.quiz,
    this.user,
  });

  int id;
  int userId;
  int quizId;
  bool solved;
  int incorrectAnswersCount;
  int answersCount;
  double correctAnswerRate;
  DateTime createdAt;
  DateTime updatedAt;
  Quiz? quiz;
  User? user;

  Weakness.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        quizId = json['quiz_id'],
        solved = json['solved'],
        incorrectAnswersCount = json['incorrect_answers_count'],
        answersCount = json['answers_count'],
        correctAnswerRate = json['correct_answer_rate'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        quiz = json['quiz'] == null ? null : Quiz.fromJson(json['quiz']),
        user = json['user'] == null ? null : User.fromJson(json['user']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'quiz_id': quizId,
        'solved': solved,
        'incorrect_answers_count': incorrectAnswersCount,
        'answers_count': answersCount,
        'correct_answer_rate': correctAnswerRate,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'quiz': quiz,
        'user': user,
      };
}
