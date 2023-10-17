import 'package:booqs_mobile/components/dictionary_map/speech/search_button.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';

class DictionaryMapSearchOptionsButton extends StatelessWidget {
  const DictionaryMapSearchOptionsButton(
      {super.key, required this.keywordController, required this.dictionary});
  final TextEditingController keywordController;
  final Dictionary? dictionary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //SpeechTestButton(dictionary: dictionary!),
        DictionaryMapSpeechSearchButton(
          dictionary: dictionary,
          keywordController: keywordController,
        )
      ],
    );
  }
}
