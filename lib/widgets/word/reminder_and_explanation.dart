import 'package:booqs_mobile/models/reminder.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/shared/text_with_link.dart';
import 'package:booqs_mobile/widgets/word/word_edit_button.dart';
import 'package:booqs_mobile/widgets/word/word_reminder_button.dart';
import 'package:flutter/material.dart';

class ReminderAndExplanation extends StatefulWidget {
  const ReminderAndExplanation({Key? key, required this.word})
      : super(key: key);
  final Word word;

  @override
  _ReminderAndExplanationState createState() => _ReminderAndExplanationState();
}

class _ReminderAndExplanationState extends State<ReminderAndExplanation> {
  bool _initDone = false;
  Word? _word;
  //Sentence? _sentence;

  @override
  void initState() {
    super.initState();
    _word = widget.word;
  }

  @override
  Widget build(BuildContext context) {
    // 　リマインダー設定ボタン
    Widget _reminderButton(word) {
      return WordReminderButton(word: word);
    }

    Widget _heading(text) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(text,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)));
    }

    Widget _pronunciationPart() {
      if (_word!.ipa == null || _word!.ipa == '') return Container();

      return Row(
        children: <Widget>[
          _heading('発音記号（IPA）'),
          const SizedBox(
            width: 12,
          ),
          Text('${_word!.ipa}', style: const TextStyle(fontSize: 16)),
        ],
      );
    }

    Widget _explanation() {
      final expText = _word!.explanation;
      return Column(
          // 左寄せ
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _heading('解説'),
            const SizedBox(height: 8),
            TextWithLink(text: expText, autoLinkEnabled: false),
          ]);
    }

    Widget _sentence() {
      final original = _word?.originalOfSentence ?? '';
      final translation = _word?.translationOfSentence ?? '';

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _heading('例文'),
        const SizedBox(height: 8),
        TextWithLink(text: original, autoLinkEnabled: true),
        const SizedBox(height: 8),
        Text(translation,
            style: const TextStyle(
                fontSize: 16, height: 1.6, color: Colors.black87)),
      ]);
    }

    return Column(
      children: <Widget>[
        _reminderButton(_word),
        const SizedBox(height: 24),
        _pronunciationPart(),
        const SizedBox(height: 24),
        _explanation(),
        const SizedBox(height: 24),
        _sentence(),
        const SizedBox(height: 24),
        WordEditButton(word: _word),
      ],
    );
  }
}
