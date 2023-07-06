import 'package:booqs_mobile/data/remote/word_requests.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final asyncWordRequestFamily = FutureProvider.autoDispose
    .family<WordRequest?, int>((ref, wordRequestId) async {
  final Map resMap = await RemoteWordRequests.show(wordRequestId);
  if (ErrorHandler.isErrorMap(resMap)) return null;
  final WordRequest wordRequest = WordRequest.fromJson(resMap['word_request']);
  return wordRequest;
});
