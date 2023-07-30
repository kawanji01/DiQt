import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/dictionary/word_requests_button.dart';
import 'package:booqs_mobile/components/dictionary/word_search_form.dart';
import 'package:booqs_mobile/pages/word/new.dart';
import 'package:flutter/material.dart';

class DictionaryWordPart extends StatelessWidget {
  const DictionaryWordPart({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${t.dictionaries.words}（${dictionary.wordsCount}）',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        DictionaryWordSearchForm(
          dictionary: dictionary,
        ),
        InkWell(
            onTap: () => WordNewPage.push(context, dictionary.id, ''),
            child: SmallOutlineGrayButton(label: t.words.add, icon: Icons.add)),
        const SizedBox(height: 8),
        DictionaryWordRequestsButton(dictionary: dictionary),
      ],
    );
  }
}
