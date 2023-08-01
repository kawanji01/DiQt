import 'package:booqs_mobile/components/shared/diff/lines.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:flutter/material.dart';

class SharedDiffWithLabel extends StatelessWidget {
  const SharedDiffWithLabel(
      {super.key,
      required this.label,
      required this.oldText,
      required this.newText,
      this.alwaysShow = false});
  final String label;
  final String? oldText;
  final String? newText;
  final bool alwaysShow;

  @override
  Widget build(BuildContext context) {
    final String previousText = oldText ?? '';
    final String nowText = newText ?? '';

    if (nowText == previousText && alwaysShow == false) {
      return Container();
    }

    Widget diff() {
      if (nowText == previousText) {
        return Text(
          nowText,
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        );
      }
      return SharedDiffLines(oldText: previousText, newText: nowText);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(
          text: label,
        ),
        const SizedBox(
          height: 8,
        ),
        diff(),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
