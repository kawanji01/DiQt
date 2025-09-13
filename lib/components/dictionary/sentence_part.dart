import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:booqs_mobile/components/dictionary/sentence_requests_button.dart';
import 'package:booqs_mobile/components/dictionary/sentence_search_form.dart';
import 'package:booqs_mobile/utils/diqt_browser_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionarySentencePart extends ConsumerWidget {
  const DictionarySentencePart({super.key, required this.dictionary});
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${t.sentences.sentences}（${dictionary.sentencesCount}）',
          style: const TextStyle(
              fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        DictionarySentenceSearchForm(dictionary: dictionary),
        InkWell(
          onTap: () {
            // ２８言語対応でフォーム画面の仕様が複雑化したので、Web編集画面に一本化する。
            DiQtBrowserDialog.open(
                context, '/sentences/new?dictionary_id=${dictionary.id}');
            // SentenceNewPage.push(context, dictionary.id, '');
          },
          child:
              SmallOutlineGrayButton(label: t.sentences.add, icon: Icons.add),
        ),
        const SizedBox(height: 8),
        DictionarySentenceRequestsButton(dictionary: dictionary),
      ],
    );
  }
}
