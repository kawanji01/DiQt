import 'package:booqs_mobile/components/dictionary/new_word_button.dart';
import 'package:booqs_mobile/components/dictionary/search_by_web_button.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryNoMoreWords extends ConsumerWidget {
  const DictionaryNoMoreWords(
      {super.key, required this.dictionaryId, required this.keyword});
  final int dictionaryId;
  final String keyword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget allLoaded(Dictionary? dictionary) {
      if (dictionary == null) {
        return const Text('Dictionary not found');
      }

      return Column(children: [
        const SizedBox(height: 48),
        DictionaryNewWordButton(dictionaryId: dictionaryId, keyword: keyword),
        const SizedBox(height: 16),
        DictionarySearchByWebButton(
          keyword: keyword,
          langNumberOfKeyword: dictionary.langNumberOfEntry,
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 48),
        const SizedBox(height: 120),
      ]);
    }

    return ref.watch(asyncDictionaryFamily(dictionaryId)).when(
        data: (dictionary) => allLoaded(dictionary),
        error: (e, trr) => Text('$e'),
        loading: () => const LoadingSpinner());
  }
}
