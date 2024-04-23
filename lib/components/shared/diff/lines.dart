import 'package:booqs_mobile/components/shared/diff/text.dart';
import 'package:flutter/material.dart';

// １行ずつ比べて差分を取得する。変更のない行は通常のテキストで表示する。
class SharedDiffLines extends StatelessWidget {
  const SharedDiffLines(
      {super.key, required this.oldText, required this.newText});
  final String oldText;
  final String newText;

  @override
  Widget build(BuildContext context) {
    if (oldText == '' && newText == '') {
      return Container();
    }

    final List<String> oldLines = oldText.split('\n');
    final List<String> newLines = newText.split('\n');

    List<Widget> children = [];
    if (newLines.length >= oldLines.length) {
      newLines.asMap().forEach((index, newLine) {
        // RangeError (index)対策
        final String oldLine = index < oldLines.length ? oldLines[index] : '';
        final diffLine = SharedDiffText(newText: newLine, oldText: oldLine);
        children.add(diffLine);
      });
    } else {
      oldLines.asMap().forEach((index, oldLine) {
        final String newLine = index < newLines.length ? newLines[index] : '';
        final diffLine = SharedDiffText(newText: newLine, oldText: oldLine);
        children.add(diffLine);
      });
    }

    return Column(
      children: children,
    );
  }
}
