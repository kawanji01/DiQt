import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/components/word/item/label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemFormsList extends StatelessWidget {
  const WordItemFormsList({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    if (word.formsList == null || (word.formsList as List).isEmpty) {
      return const SizedBox.shrink();
    }

    final List<dynamic> forms = word.formsList as List<dynamic>;

    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: WordItemLabel(
              text: t.words.related,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: forms.map((form) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWithDictLink(
                      text: form['form']?.toString() ?? '',
                      langNumber: word.langNumberOfMeaning,
                      autoLinkEnabled: true,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      dictionaryId: word.dictionaryId,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontColor: Colors.black87,
                      selectable: true,
                    ),
                    if (form['tags'] != null)
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: (form['tags'] as List)
                              .map<Widget>((tag) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[600],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      tag.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
