import 'package:booqs_mobile/data/remote/word_tags.dart';
import 'package:booqs_mobile/models/word_tag.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wordTagProvider = StateProvider<WordTag?>((ref) => null);

final asyncWordTagFamily =
    FutureProvider.autoDispose.family<WordTag?, int>((ref, wordTagId) async {
  final Map resMap = await RemoteWordTags.show(wordTagId);
  if (ErrorHandler.isErrorMap(resMap)) return null;
  final WordTag wordTag = WordTag.fromJson(resMap['word_tag']);
  return wordTag;
});
