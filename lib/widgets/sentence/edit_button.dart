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
    Widget editButton() {
      return Container(
        // 左寄せ
        alignment: Alignment.topLeft,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black54,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: () {
            SentenceEditPage.push(context, sentence.id);
          },
          child: const Text(
            '例文を改善する',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    Widget deatailButton() {
      if (isShow) return Container();

      return Container(
        // 左寄せ
        alignment: Alignment.topRight,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black54,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: () {
            SentenceShowPage.push(context, sentence.id);
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
      children: [editButton(), deatailButton()],
    );
  }
}
