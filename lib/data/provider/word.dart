import 'package:booqs_mobile/models/word.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wordSearchKeywordProvider = StateProvider<String?>((ref) => null);

final wordsProvider = StateProvider<List<Word>>((ref) => []);

/* final asyncSearchWordsProvider = FutureProvider<List<Word>>((ref) async {
  final List<Word> words = [];
  final String? keyword = ref.watch(wordSearchKeywordProvider);
  if (keyword == null) return words;
  final Map? resMap = await RemoteWords.search(keyword);
  if (resMap == null) return words;
  resMap['words'].forEach((e) => words.add(Word.fromJson(e)));
  final Dictionary dictionary = Dictionary.fromJson(resMap['dictionary']);
  // providerの更新
  ref.read(wordsProvider.notifier).state = words;
  ref.read(dictionaryProvider.notifier).state = dictionary;
  return words;
});
 */