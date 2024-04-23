import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';

class SharedDeleteConfirmation extends StatelessWidget {
  const SharedDeleteConfirmation({
    super.key,
    required this.onDeletePressed,
  });
  final void Function() onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.shared.destroy_confirmation,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            const SizedBox(height: 16),
            Text(t.shared.destroy_confirmation_description,
                style: const TextStyle(fontSize: 16, color: Colors.black87)),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: onDeletePressed,
              icon: const Icon(Icons.delete, color: Colors.white),
              label: Text(
                t.shared.destroy,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
