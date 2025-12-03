import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordPronunciations extends StatelessWidget {
  const WordPronunciations({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    final bool isJapaneseEntry =
        word.langNumberOfEntry == languageCodeMap['ja'];
    final List<Widget> items = [];

    void addLine(String label, String? value,
        {bool small = false, bool japaneseOnly = false}) {
      if (value == null || value.trim().isEmpty) return;
      if (japaneseOnly && !isJapaneseEntry) return;
      if (items.isNotEmpty) {
        items.add(const SizedBox(height: 4));
      }
      items.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: small ? 12 : 14,
                fontWeight: FontWeight.normal,
                color: Colors.green.shade700,
              ),
            ),
          ),
        ],
      ));
    }

    addLine(t.words.reading, word.reading, japaneseOnly: true);
    addLine(t.words.hiragana, word.hiragana);
    addLine(t.words.kanji, word.kanji);
    addLine(t.words.kunyomi, word.kunyomi);
    addLine(t.words.onyomi, word.onyomi);
    addLine(t.words.pinyin, word.pinyin);
    addLine(t.words.jyutping, word.jyutping);
    addLine(t.words.ipa, word.ipa, small: true);

    if (items.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }
}
