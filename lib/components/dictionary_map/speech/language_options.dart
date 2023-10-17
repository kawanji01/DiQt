import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechLanguageOptions extends StatelessWidget {
  const SpeechLanguageOptions(
      this.currentLocaleId, this.switchLang, this.localeNames,
      {Key? key})
      : super(key: key);

  final String currentLocaleId;
  final void Function(String?) switchLang;
  final List<LocaleName> localeNames;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // overflow対策
      isExpanded: true,
      onChanged: (selectedVal) => switchLang(selectedVal),
      value: currentLocaleId,
      items: localeNames
          .map(
            (localeName) => DropdownMenuItem(
              value: localeName.localeId,
              child: Text(
                localeName.name,
                // overflow対策
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
    );
  }
}
