import 'package:booqs_mobile/widgets/markdown/markdown_without_dict_link.dart';
import 'package:flutter/material.dart';

class QuizChoiceButton extends StatelessWidget {
  const QuizChoiceButton(
      {Key? key, required this.answerText, required this.selected})
      : super(key: key);
  final String answerText;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.green,
        ),
        child: MarkdownWithoutDictLink(
          text: answerText,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontColor: Colors.white,
          selectable: false,
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: MarkdownWithoutDictLink(
        text: answerText,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontColor: Colors.green,
        selectable: false,
      ),
    );
  }
}
