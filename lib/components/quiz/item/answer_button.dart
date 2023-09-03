import 'package:flutter/material.dart';

class QuizItemAnswerButton extends StatelessWidget {
  const QuizItemAnswerButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.onPressed,
      required this.selected});
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return InkWell(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 8, bottom: 12, left: 8, right: 8),
          margin: const EdgeInsets.symmetric(vertical: 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: Colors.green,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: Colors.white, size: 18.0),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16))
          ]),
        ),
      );
    }

    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 8, bottom: 12, left: 8, right: 8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: Colors.green, size: 18.0),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16))
        ]),
      ),
    );
  }
}
