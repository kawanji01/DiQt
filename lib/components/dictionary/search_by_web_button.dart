import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';

class DictionarySearchByWebButton extends StatelessWidget {
  const DictionarySearchByWebButton(
      {Key? key, required this.keyword, required this.langNumberOfKeyword})
      : super(key: key);
  final String keyword;
  final int langNumberOfKeyword;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () =>
            WebPageLauncher.searchEntryByGoogle(keyword, langNumberOfKeyword),
        child: MediumGreenButton(
          label: t['dictionaries.search_by_web'],
          fontSize: 16,
          icon: Icons.search,
        ));
  }
}
