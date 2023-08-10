import 'package:booqs_mobile/components/sentence/setting/setting.dart';
import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SenseFormSentenceSetting extends ConsumerWidget {
  const SenseFormSentenceSetting(
      {super.key, required this.sentenceIdController});
  final TextEditingController sentenceIdController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, TextEditingController> wordControllerMap =
        ref.watch(wordControllerMapProvider);
    final TextEditingController entryController =
        wordControllerMap['entry'] ?? TextEditingController();
    final TextEditingController posTagIdController =
        wordControllerMap['pos_tag_id'] ?? TextEditingController();
    final Dictionary? dictionary = ref.watch(wordEditDictionaryProvider);
    if (dictionary == null) {
      return Container();
    }
    final String entry = entryController.text;
    print('entry: $entry');

    return SentenceSetting(
        sentenceIdController: sentenceIdController,
        entry: entry,
        posTagIdController: posTagIdController,
        dictionary: dictionary);
  }
}
