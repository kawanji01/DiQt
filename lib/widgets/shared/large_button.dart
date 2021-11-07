import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({Key? key, required this.btnText}) : super(key: key);
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: const Color(0xff84bf53).withAlpha(100),
                offset: const Offset(2, 4),
                blurRadius: 8,
                spreadRadius: 2)
          ],
          color: Colors.green),
      child: Text(
        btnText,
        style: const TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
