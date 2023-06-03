import 'package:booqs_mobile/components/button/medium_red_button.dart';
import 'package:booqs_mobile/components/dictionary_map/removal_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class DictionaryMapRemovalButton extends StatelessWidget {
  const DictionaryMapRemovalButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pop();
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
            builder: (context) => const DictionaryMapRemovalScreen(),
          );
        },
        child: MediumRedButton(
          label: t.dictionaryMaps.remove_dictionaries,
          icon: Icons.remove,
          fontSize: 18,
        ));
  }
}
