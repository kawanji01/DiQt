import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sentenceProvider = StateProvider<Sentence?>((ref) => null);
final asyncSentenceProvider = FutureProvider<Sentence?>((ref) async {
  final int? sentenceId =
      ref.watch(sentenceProvider.select((sentence) => sentence?.id));
  if (sentenceId == null) return null;

  final Map? resMap = await RemoteSentences.show(sentenceId);
  if (resMap == null) return null;
  final Sentence sentence = Sentence.fromJson(resMap['sentence']);
  ref.read(sentenceProvider.notifier).state = sentence;
  return sentence;
});
