import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/models/user.dart';

class QuizRequestComment {
  QuizRequestComment({
    required this.id,
    required this.quizRequestId,
    required this.body,
    required this.dictionaryId,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.quizRequest,
  });
  final int id;
  final int quizRequestId;
  final String body;
  final int? dictionaryId;
  final String createdAt;
  final String updatedAt;
  final User? user;
  final QuizRequest? quizRequest;

  factory QuizRequestComment.fromJson(Map<String, dynamic> json) {
    return QuizRequestComment(
      id: json['id'],
      quizRequestId: json['quiz_request_id'],
      body: json['body'],
      dictionaryId: json['dictionary_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      quizRequest: json['quiz_request'] != null
          ? QuizRequest.fromJson(json['quiz_request'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quiz_request_id': quizRequestId,
      'body': body,
      'dictionary_id': dictionaryId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user,
      'quiz_request': quizRequest,
    };
  }
}
