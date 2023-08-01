import 'package:booqs_mobile/data/remote/sentence_requests.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/models/sentence_request_comment.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final asyncSentenceRequestFamily = FutureProvider.autoDispose
    .family<SentenceRequest?, int>((ref, sentenceRequestId) async {
  final Map resMap = await RemoteSentenceRequests.show(sentenceRequestId);
  if (ErrorHandler.isErrorMap(resMap)) return null;
  final SentenceRequest sentenceRequest =
      SentenceRequest.fromJson(resMap['sentence_request']);
  return sentenceRequest;
});

final asyncSentenceRequestCommentsFamily = FutureProvider.autoDispose
    .family<List<SentenceRequestComment>, int>((ref, sentenceRequestId) async {
  final Map resMap = await RemoteSentenceRequests.comments(sentenceRequestId);
  if (ErrorHandler.isErrorMap(resMap)) return [];
  final List<SentenceRequestComment> sentenceRequestComments =
      (resMap['sentence_request_comments'] as List)
          .map((e) => SentenceRequestComment.fromJson(e))
          .toList();
  return sentenceRequestComments;
});
