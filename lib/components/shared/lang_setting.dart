import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/language_handler.dart';
import 'package:flutter/material.dart';

class SharedLangSetting extends StatelessWidget {
  const SharedLangSetting({Key? key, required this.langNumber})
      : super(key: key);
  final int langNumber;

  @override
  Widget build(BuildContext context) {
    final String language = LanguageHandler.getLanguageFromNumber(langNumber);
    final String? languageSetting = t['lang.language_setting'];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: '$languageSetting:',
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.normal)),
          TextSpan(
              text: ' $language',
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
