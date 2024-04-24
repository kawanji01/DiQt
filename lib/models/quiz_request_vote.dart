import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/models/user.dart';

class QuizRequestVote {
  QuizRequestVote(
      {required this.id,
      required this.quizRequestId,
      required this.userId,
      required this.upvoted,
      this.quizRequest,
      this.user});
  final int id;
  final int quizRequestId;
  final int userId;
  final bool upvoted;
  final QuizRequest? quizRequest;
  final User? user;

  factory QuizRequestVote.fromJson(Map<String, dynamic> json) {
    return QuizRequestVote(
      id: json['id'],
      quizRequestId: json['quiz_request_id'],
      userId: json['user_id'],
      upvoted: json['upvoted'],
      quizRequest: json['quiz_request'] != null
          ? QuizRequest.fromJson(json['quiz_request'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quiz_request_id': quizRequestId,
      'user_id': userId,
      'upvoted': upvoted,
      'quiz_request': quizRequest?.toJson(),
      'user': user?.toJson(),
    };
  }
}
