import 'package:booqs_mobile/components/chapter/card_list.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/data/provider/chapter.dart';
import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/language_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordBookIndex extends ConsumerWidget {
  const WordBookIndex({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Build dropdown from wordBookSupportedDictIds only
    final entries = wordBookSupportedDictIds.entries.toList();
    final selectedId = ref.watch(wordBookDictionaryIdProvider);
    final containsSelected = entries.any((e) => e.value == selectedId);

    if (!containsSelected && entries.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(wordBookDictionaryIdProvider.notifier).state =
            entries.first.value;
      });
    }

    final selector = Container(
      margin: const EdgeInsets.only(top: 16),
      height: 48,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 15.0, right: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black87),
      ),
      child: DropdownButton<int>(
        value: containsSelected ? selectedId : null,
        iconSize: 24,
        elevation: 16,
        isExpanded: true,
        hint: Text(t.dictionaryMaps.please_select),
        underline: const SizedBox.shrink(),
        onChanged: (value) {
          if (value == null) return;
          ref.read(wordBookDictionaryIdProvider.notifier).state = value;
          ref.invalidate(asyncChapterWordBookProvider);
        },
        items: entries
            .map(
              (e) => DropdownMenuItem<int>(
                value: e.value,
                child: Text(
                  LanguageHandler.getLanguageFromCode(e.key),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );

    final chaptersAsync = ref.watch(asyncChapterWordBookProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        selector,
        const SizedBox(height: 12),
        chaptersAsync.when(
          loading: () => const LoadingSpinner(),
          error: (e, st) => Text('Error: $e'),
          data: (chapters) => ChapterCardList(chapters: chapters ?? []),
        ),
      ],
    );
  }
}
