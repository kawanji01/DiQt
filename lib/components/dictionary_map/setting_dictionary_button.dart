// lib/components/dictionary_map/setting_button.dart
import 'package:flutter/material.dart';
import 'package:booqs_mobile/components/dictionary_map/setting_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';


class DictionaryMapSettingButton extends StatelessWidget {
  const DictionaryMapSettingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // キーボードを閉じる
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)
              ),
            ),
            builder: (context) => const DictionaryMapSettingScreen(),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          t.dictionaryMaps.set_dictionaries,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}