import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wordSearchKeywordProvider = StateProvider<String?>((ref) => null);

final wordsProvider = StateProvider<List<Word>>((ref) => []);

final wordProvider = StateProvider<Word?>((ref) => null);
final wordIdProvider = StateProvider<int?>((ref) => null);
final asyncWordProvider = FutureProvider<Word?>((ref) async {
  final int? id = ref.watch(wordIdProvider);
  if (id == null) return null;
  final Map? resMap = await RemoteWords.show(id);
  if (resMap == null) return null;
  final Word word = Word.fromJson(resMap['word']);
  ref.read(wordProvider.notifier).state = word;
  return word;
});

// 辞書編集画面の例文
final wordSentenceProvider = StateProvider<Sentence?>((ref) => null);
