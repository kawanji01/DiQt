import 'package:booqs_mobile/models/quiz.dart';

class Note {
  Note({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.quiz,
  });

  int id;
  int userId;
  int quizId;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  Quiz? quiz;

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        quizId = json['quiz_id'],
        content = json['content'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        quiz = json['quiz'] == null ? null : Quiz.fromJson(json['quiz']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'quiz_id': quizId,
        'content': content,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'quiz': quiz,
      };
}
