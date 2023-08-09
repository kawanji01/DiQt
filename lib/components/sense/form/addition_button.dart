import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SenseFormAdditionButton extends StatelessWidget {
  const SenseFormAdditionButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
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
    );
  }
}
