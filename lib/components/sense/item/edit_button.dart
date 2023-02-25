import 'package:booqs_mobile/models/sense.dart';
import 'package:booqs_mobile/pages/sense/edit.dart';
import 'package:booqs_mobile/pages/sense/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SenseItemEditButton extends ConsumerWidget {
  const SenseItemEditButton(
      {Key? key, required this.sense, required this.isShow})
      : super(key: key);
  final Sense sense;
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
            textStyle: const TextStyle(fontSize: 15),
          ),
          onPressed: () {
            SenseEditPage.push(context, sense.id);
          },
          child: const Text(
            '意味を編集する',
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
            textStyle: const TextStyle(fontSize: 15),
          ),
          onPressed: () {
            SenseShowPage.push(context, sense.id);
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
