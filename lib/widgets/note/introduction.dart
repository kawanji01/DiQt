import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteIntroduction extends ConsumerWidget {
  const NoteIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heading = RichText(
        text: const TextSpan(children: [
      WidgetSpan(
        child: Icon(
          Icons.note_alt_outlined,
          color: Colors.black,
          size: 36.0,
        ),
      ),
      TextSpan(
          text: ' ノート',
          style: TextStyle(
              color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold))
    ]));

    final introduction = Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        'ノートを書いた問題を一覧します。',
        style: TextStyle(
            color: Colors.black87, fontSize: 16, fontWeight: FontWeight.normal),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading,
        const SizedBox(
          height: 8,
        ),
        introduction,
      ],
    );
  }
}
