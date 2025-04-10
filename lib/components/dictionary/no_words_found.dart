import 'package:booqs_mobile/components/ad/banner.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/dictionary/new_word_button.dart';
import 'package:booqs_mobile/components/dictionary/search_by_web_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryNoWordsFound extends ConsumerWidget {
  const DictionaryNoWordsFound(
      {super.key, required this.dictionaryId, required this.keyword});
  final String keyword;
  final int dictionaryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget noWordFound(Dictionary? dictionary) {
      if (dictionary == null) {
        return const Text('Error: Dictionary not found.');
      }
      return Column(
        children: <Widget>[
          const SizedBox(height: 48),
          Text(
            entryLengthLimitation < keyword.length
                ? ''
                : t.dictionaries.keyword_not_found,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 40),
          DictionaryNewWordButton(
              dictionaryId: dictionary.id, keyword: keyword),
          const SizedBox(height: 16),
          DictionarySearchByWebButton(
            keyword: keyword,
            langNumberOfKeyword: dictionary.langNumberOfEntry,
          ),
          const SizedBox(height: 80),
          const AdBanner(),
        ],
      );
    }

    return ref.watch(asyncDictionaryFamily(dictionaryId)).when(
        data: (data) => noWordFound(data),
        error: (e, trr) => Text('$e'),
        loading: () => const LoadingSpinner());
  }
}
