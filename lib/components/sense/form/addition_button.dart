import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SenseFormAdditionButton extends StatelessWidget {
  const SenseFormAdditionButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SmallGreenButton(label: t.senses.add, icon: Icons.add),
    );

    /* return Container(
      margin: const EdgeInsets.only(top: 24),
      height: 40,
      width: double.infinity,
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: onPressed,
          icon: const Icon(Icons.add),
          label: Text(t.senses.add,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold))),
    ); */
  }
}
