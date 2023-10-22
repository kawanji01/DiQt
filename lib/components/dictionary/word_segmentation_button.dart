import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class DictionaryWordSegmentationButton extends StatelessWidget {
  const DictionaryWordSegmentationButton(
      {super.key,
      required this.langNumber,
      required this.separated,
      required this.performWordSegmentation});
  final int langNumber;
  final bool separated;
  final void Function() performWordSegmentation;

  @override
  Widget build(BuildContext context) {
    if (segmentationNeededLangNumbers.contains(langNumber) == false) {
      return Container();
    }
    if (separated) {
      return Container();
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: performWordSegmentation,
        child: Text(t.dictionaries.word_segmentation,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            )),
      ),
    );
  }
}
