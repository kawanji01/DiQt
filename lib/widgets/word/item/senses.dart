import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/word/item/label.dart';
import 'package:booqs_mobile/widgets/word/item/small_translation_buttons.dart';
import 'package:booqs_mobile/widgets/word/item/text.dart';
import 'package:flutter/material.dart';

class WordItemSenses extends StatelessWidget {
  const WordItemSenses({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    if (word.sensesJson == null || word.sensesJson == []) return Container();
    final List _sensesList = word.sensesJson!;

    // 意味
    Widget _gloss(int number, Map<String, dynamic> senseMap) {
      final String gloss =
          senseMap['raw_glosses'] != null && senseMap['raw_glosses'] != ''
              ? senseMap['raw_glosses'].join('; ')
              : senseMap['glosses'].join('; ');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WordItemLabel(text: '意味($number)'),
          const SizedBox(height: 8),
          WordItemText(word: word, text: gloss),
          WordItemSmallTranslationButtons(word: word, original: gloss),
          const SizedBox(height: 32),
        ],
      );
    }

    // 意味のリスト
    final List<Widget> _glossesList = [];
    int i = 1;
    for (var sense in _sensesList) {
      _glossesList.add(_gloss(i, sense));
      i += 1;
    }

    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _glossesList,
      ),
    );
  }
}