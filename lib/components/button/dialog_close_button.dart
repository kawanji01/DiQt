import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class DialogCloseButton extends StatelessWidget {
  const DialogCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton.icon(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          label: Text(t.shared.close,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
