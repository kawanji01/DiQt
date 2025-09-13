import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/dictionary/word_requests_button.dart';
import 'package:booqs_mobile/components/dictionary/word_search_form.dart';
import 'package:booqs_mobile/utils/diqt_browser_dialog.dart';
import 'package:flutter/material.dart';

class DictionaryWordPart extends StatelessWidget {
  const DictionaryWordPart({super.key, required this.dictionary});
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
            onTap: () {
              // ２８言語対応でフォーム画面の仕様が複雑化したので、Web編集画面に一本化する。
              DiQtBrowserDialog.open(
                  context, '/words/new?dictionary_id=${dictionary.id}');
              // WordNewPage.push(context, dictionary.id, '');
            },
            child: SmallOutlineGrayButton(label: t.words.add, icon: Icons.add)),
        const SizedBox(height: 8),
        DictionaryWordRequestsButton(dictionary: dictionary),
      ],
    );
  }
}
