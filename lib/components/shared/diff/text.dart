import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SharedDiffText extends StatelessWidget {
  const SharedDiffText(
      {super.key,
      required this.oldText,
      required this.newText,
      this.marked = true});
  final String oldText;
  final String newText;
  final bool marked;

  @override
  Widget build(BuildContext context) {
    const TextStyle normalTextStyle =
        TextStyle(color: Colors.black, fontSize: 16, height: 1.5);

    if (oldText == newText) {
      return Text(
        newText,
        style: normalTextStyle,
      );
    }
    final dmp = DiffMatchPatch();

    Widget oldLineContainer() {
      final List<Diff> diffs = dmp.diff(oldText, newText);
      List<TextSpan> spans = [];

      for (var diff in diffs) {
        String text = diff.text;
        TextStyle textStyle = normalTextStyle;

        if (diff.operation == DIFF_DELETE && marked) {
          textStyle = const TextStyle(
              color: Colors.black,
              fontSize: 16,
              backgroundColor: Color(0xFFFFC1BF));
        } else if (diff.operation == DIFF_INSERT) {
          continue;
        }
        spans.add(TextSpan(text: text, style: textStyle));
      }
      return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            color: Color(
              0xFFFFEBE9,
            ),
          ),
          child: Row(children: [
            const FaIcon(
              FontAwesomeIcons.minus,
              size: 18,
              color: Colors.red,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: RichText(
                text: TextSpan(children: spans),
              ),
            ),
          ]));
    }

    Widget newLineContainer() {
      final List<Diff> diffs = dmp.diff(oldText, newText);
      List<TextSpan> spans = [];

      for (var diff in diffs) {
        String text = diff.text;
        TextStyle textStyle =
            const TextStyle(color: Colors.black, fontSize: 16);
        if (diff.operation == DIFF_INSERT && marked) {
          textStyle = const TextStyle(
              color: Colors.black,
              fontSize: 16,
              backgroundColor: Color(0xFFABF2BB));
        } else if (diff.operation == DIFF_DELETE) {
          continue;
        }
        spans.add(TextSpan(text: text, style: textStyle));
      }
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(
            0xFFE6FFEB,
          ),
        ),
        child: Row(
          children: [
            const FaIcon(
              FontAwesomeIcons.plus,
              size: 18,
              color: Colors.green,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: RichText(
                text: TextSpan(children: spans),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [oldLineContainer(), newLineContainer()],
    );
  }
}
