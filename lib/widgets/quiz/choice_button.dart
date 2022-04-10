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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.green,
        ),
        child: Text(
          answerText,
          style: const TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        answerText,
        style: const TextStyle(
            fontSize: 15, color: Colors.green, fontWeight: FontWeight.bold),
      ),
    );
  }
}
