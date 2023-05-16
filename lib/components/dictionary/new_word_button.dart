import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/word/new.dart';
import 'package:flutter/material.dart';

class DictionaryNewWordButton extends StatelessWidget {
  const DictionaryNewWordButton(
      {Key? key, required this.dictionaryId, required this.keyword})
      : super(key: key);
  final int dictionaryId;
  final String? keyword;

  @override
  Widget build(BuildContext context) {
    String label;
    if (keyword == null || keyword == '') {
      label = t.words.add;
    } else {
      label = t.dictionaries.add_keyword_to_dictionary(keyword: keyword ?? '');
    }

    return InkWell(
        onTap: () => WordNewPage.push(context, dictionaryId, keyword ?? ''),
        child: MediumGreenButton(label: label, icon: Icons.add));
  }
}
