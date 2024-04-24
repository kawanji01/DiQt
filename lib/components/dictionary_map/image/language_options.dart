import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/utils/language_handler.dart';
import 'package:flutter/material.dart';

class DictionaryMapImageLanguageOptions extends StatelessWidget {
  const DictionaryMapImageLanguageOptions({
    super.key,
    required this.currentLocale,
    required this.switchLang,
  });
  final String currentLocale;
  final void Function(String?) switchLang;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // overflow対策
      isExpanded: true,
      onChanged: (selectedVal) => switchLang(selectedVal),
      value: currentLocale,
      items: azureImageAnalysisLanguages
          .map(
            (localeName) => DropdownMenuItem(
              value: localeName,
              child: Text(
                LanguageHandler.getLanguageFromCode(localeName),
                // overflow対策
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
    );
  }
}
