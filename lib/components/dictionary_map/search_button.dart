import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class DictionaryMapSearchButton extends StatelessWidget {
  const DictionaryMapSearchButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: const Size(double.infinity, 40),
        ),
        onPressed: onPressed,
        icon: const Icon(Icons.search, color: Colors.white),
        label: Text(
          t.shared.search,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
