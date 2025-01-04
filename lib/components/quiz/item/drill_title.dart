import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizItemDrillTitle extends ConsumerWidget {
  const QuizItemDrillTitle({super.key, required this.drill});
  final Drill drill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.only(bottom: 4),
      child: TextButton(
        // デフォルトのpadddingを消す ref: https://crieit.net/posts/Flutter-TextButton
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          minimumSize: WidgetStateProperty.all(Size.zero),
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
