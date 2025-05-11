import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/data/provider/grammatical_tag.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'grammatical_tag_select_sheet.dart';

class WordFormGrammaticalTagSelector extends ConsumerWidget {
  final int dictionaryId;
  const WordFormGrammaticalTagSelector({super.key, required this.dictionaryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTagIds = ref.watch(grammaticalTagIdsProvider);
    final asyncTags = ref.watch(asyncGrammaticalTagsFamily(dictionaryId));

    return asyncTags.when(
      data: (tags) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SharedItemLabel(text: t.grammaticalTags.grammatical_tag),
            const SizedBox(height: 8),
            if (tags == null || tags.isEmpty || selectedTagIds.isEmpty)
              Text(t.grammaticalTags.grammatical_tag_not_selected)
            else
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: tags
                    .where((tag) => selectedTagIds.contains(tag.id))
                    .map((tag) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tag.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final result = await showModalBottomSheet<List<int>>(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => GrammaticalTagSelectSheet(
                    allTags: tags!,
                    selectedTagIds: selectedTagIds,
                  ),
                );
                if (result != null) {
                  ref.read(grammaticalTagIdsProvider.notifier).state = result;
                }
              },
              child: Text(t.grammaticalTags.grammatical_tag_select,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Error: $e'),
    );
  }
}
