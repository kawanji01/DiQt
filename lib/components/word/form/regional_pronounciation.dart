import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class WordFormRegionalPronunciation extends StatefulWidget {
  const WordFormRegionalPronunciation(
      {super.key, required this.regionalPronunciationController});
  final TextEditingController regionalPronunciationController;

  @override
  State<WordFormRegionalPronunciation> createState() =>
      WordFormRegionalPronunciationState();
}

class WordFormRegionalPronunciationState
    extends State<WordFormRegionalPronunciation> {
  late bool _isSwitched;
  @override
  void initState() {
    super.initState();
    final String regionalPronunciationControllerStr =
        widget.regionalPronunciationController.text;
    if (regionalPronunciationControllerStr == 'true') {
      _isSwitched = true;
    } else {
      _isSwitched = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: Text(t.words.regional_pronunciation,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        value: _isSwitched,
        onChanged: (bool value) {
          widget.regionalPronunciationController.text = '$value';
          setState(() {
            _isSwitched = value;
          });
        },
        secondary: const Icon(Icons.check));
  }
}
