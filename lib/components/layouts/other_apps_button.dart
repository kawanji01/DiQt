import 'package:booqs_mobile/components/layouts/other_apps_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class OtherAppsButton extends StatelessWidget {
  const OtherAppsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            // 丸める
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
            builder: (context) {
              return const OtherAppsScreen();
            });
      },
      icon: const Icon(
        Icons.lightbulb_outline,
        size: 18,
        color: Colors.green,
      ),
      label: Text(t.layouts.other_apps,
          style: const TextStyle(
              fontSize: 16,
              color: Colors.green,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.underline)),
    );
  }
}
