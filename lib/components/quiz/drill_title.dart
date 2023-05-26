import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizDrillTitle extends ConsumerStatefulWidget {
  const QuizDrillTitle({Key? key, required this.drill}) : super(key: key);
  final Drill drill;

  @override
  QuizDrillTitleState createState() => QuizDrillTitleState();
}

class QuizDrillTitleState extends ConsumerState<QuizDrillTitle> {
  @override
  Widget build(BuildContext context) {
    final Drill drill = widget.drill;

    return Container(
      alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.only(bottom: 4),
      child: TextButton(
        // デフォルトのpadddingを消す ref: https://crieit.net/posts/Flutter-TextButton
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          ref.read(drillProvider.notifier).state = drill;
          DrillUnsolvedPage.push(context);
        },
        child: Text(
          drill.title,
          style: const TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ),
    );
  }
}
