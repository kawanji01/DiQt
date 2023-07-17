import 'package:booqs_mobile/components/dictionary_map/addition_button.dart';
import 'package:booqs_mobile/components/dictionary_map/removal_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';

class DictionaryMapSettingScreen extends StatelessWidget {
  const DictionaryMapSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 40%の高さ
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 40;

    return SizedBox(
        height: height,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveValues.horizontalMargin(context)),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 24,
                ),
                Text(
                  t.dictionaryMaps.set_dictionaries,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(
                  height: 40,
                ),
                const DictionaryMapAdditionButton(),
                const SizedBox(
                  height: 24,
                ),
                const DictionaryMapRemovalButton(),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ));
  }
}
