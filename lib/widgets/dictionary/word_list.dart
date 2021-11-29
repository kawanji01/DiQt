import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/dictionary/word.dart';
import 'package:booqs_mobile/utils/tts_button.dart';
import 'package:booqs_mobile/widgets/word/tag_buttons.dart';
import 'package:booqs_mobile/widgets/word/word_explanation.dart';
import 'package:booqs_mobile/widgets/word/word_reminder_button.dart';
import 'package:flutter/material.dart';

class WordList extends StatelessWidget {
  const WordList({Key? key, required this.words}) : super(key: key);
  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    Future _moveToWordPage(word) async {
      await WordPage.push(context, word);
    }

    Widget _buildRow(int index) {
      final word = words[index];

      // タグ
      Widget _tags() {
        if (word.tags == null) {
          return Container();
        }
        List tagsList = word.tags!.split(',');
        return TagButtons(tagsList: tagsList);
      }

      // 項目
      Widget _entryPart() {
        // 左寄せできない問題の解決策としてdouble.infinityを設定する。https://techsmeme.com/flutter-text-left-right/
        return SizedBox(
          width: double.infinity,
          child: Wrap(
            children: <Widget>[
              Text(
                word.entry,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TtsButton(
                  speechText: word.entry, langNumber: word.langNumberOfEntry),
            ],
          ),
        );
      }

      Widget _title() {
        return Column(children: <Widget>[
          _tags(),
          const SizedBox(height: 10),
          _entryPart(),
        ]);
      }

      Widget _meaningPart() {
        return SizedBox(
          width: double.infinity,
          child: Text(word.meaning,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        );
      }

      return ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 24),
        title: _title(),
        subtitle: Column(children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          _meaningPart(),
          const SizedBox(
            height: 24,
          ),
          WordReminderButton(word: word),
          WordExplanation(word: word),
        ]),
        // onTap: () => _moveToWordPage(word),
        onTap: () => print('click'),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) => _buildRow(index),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: words.length,
    );
  }
}
