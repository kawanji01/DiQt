import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/word/word_edit_button.dart';
import 'package:booqs_mobile/widgets/word/word_entry.dart';
import 'package:booqs_mobile/widgets/word/word_explanation.dart';
import 'package:booqs_mobile/widgets/word/word_meaning.dart';
import 'package:booqs_mobile/widgets/word/word_review_button.dart';
import 'package:booqs_mobile/widgets/word/word_sentence.dart';
import 'package:booqs_mobile/widgets/word/word_tag_buttons.dart';
import 'package:flutter/material.dart';

class WordTile extends StatelessWidget {
  const WordTile({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    //Future _moveToWordPage(word) async {
    //  await WordShowPage.push(context, word);
    //}

    Widget _title() {
      return Column(children: <Widget>[
        WordTagButtons(tags: word.tags),
        const SizedBox(height: 10),
        WordEntry(word: word),
      ]);
    }

    Widget _subtitle() {
      return Column(children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        WordMeaning(word: word),
        const SizedBox(
          height: 24,
        ),
        WordReviewButton(word: word),
        WordExplanation(word: word),
        WordSentence(word: word),
        WordEditButton(word: word),
      ]);
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 24),
      title: _title(),
      subtitle: _subtitle(),
      // onTap: () => _moveToWordPage(word),
      onTap: () => print('click'),
    );
  }
}
