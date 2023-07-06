import 'package:booqs_mobile/components/dictionary_map/setting_screen.dart';
import 'package:flutter/material.dart';

class DictionaryMapFloatingActionButton extends StatelessWidget {
  const DictionaryMapFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          // 丸み ref: https://www.codegrepper.com/code-examples/whatever/showmodalbottomsheet+rounded+corners
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
          ),
          // showModalBottomSheetで表示される中身
          builder: (context) => const DictionaryMapSettingScreen(),
        );
      },
      backgroundColor: Colors.green,
      child: const Icon(Icons.settings),
    );
  }
}
