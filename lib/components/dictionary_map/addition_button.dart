import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/dictionary_map/addition_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class DictionaryMapAdditionButton extends StatelessWidget {
  const DictionaryMapAdditionButton({super.key});

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
            // showModalBottomSheetで表示される中身
            builder: (context) => const DictionaryMapAdditionScreen(),
          );
        },
        child: MediumGreenButton(
          label: t.dictionaryMaps.add_dictionaries,
          fontSize: 18,
          icon: Icons.add,
        ));
  }
}
