import 'package:booqs_mobile/data/remote/quiz_requests.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/models/quiz_request_comment.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final asyncQuizRequestFamily = FutureProvider.autoDispose
    .family<QuizRequest?, int>((ref, quizRequestId) async {
  final Map resMap = await RemoteQuizRequests.show(quizRequestId);
  if (ErrorHandler.isErrorMap(resMap)) return null;
  final QuizRequest quizRequest = QuizRequest.fromJson(resMap['quiz_request']);
  return quizRequest;
});

final asyncQuizRequestCommentsFamily = FutureProvider.autoDispose
    .family<List<QuizRequestComment>, int>((ref, quizRequestId) async {
  final Map resMap = await RemoteQuizRequests.comments(quizRequestId);
  if (ErrorHandler.isErrorMap(resMap)) return [];
  final List<QuizRequestComment> quizRequestComments =
      (resMap['quiz_request_comments'] as List)
          .map((e) => QuizRequestComment.fromJson(e))
          .toList();
  return quizRequestComments;
});
