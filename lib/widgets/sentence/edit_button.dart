import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/pages/sentence/edit.dart';
import 'package:booqs_mobile/pages/sentence/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceEditButton extends ConsumerWidget {
  const SentenceEditButton(
      {Key? key, required this.sentence, required this.isShow})
      : super(key: key);
  final Sentence sentence;
  final bool isShow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget _editButton() {
      return Container(
        // 左寄せ
        alignment: Alignment.topLeft,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            primary: Colors.black54,
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: () {
            ref.read(sentenceProvider.notifier).state = sentence;
            SentenceEditPage.push(context);
          },
          child: const Text(
            'この例文を改善する',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    Widget _deatailButton() {
      if (isShow) return Container();

      return Container(
        // 左寄せ
        alignment: Alignment.topRight,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            primary: Colors.black54,
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: () {
            ref.read(sentenceProvider.notifier).state = sentence;
            SentenceShowPage.push(context);
          },
          child: const Text(
            '詳細',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_editButton(), _deatailButton()],
    );
  }
}
