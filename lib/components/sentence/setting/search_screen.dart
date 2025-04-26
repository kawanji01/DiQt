import 'package:booqs_mobile/components/sentence/setting/addition_screen.dart';
import 'package:booqs_mobile/components/sentence/setting/heading.dart';
import 'package:booqs_mobile/components/sentence/setting/list_view.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';

class SentenceSettingSearchScreen extends StatelessWidget {
  const SentenceSettingSearchScreen(
      {super.key, required this.keyword, required this.dictionary});
  final String keyword;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

    void additionPressed() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
          ),
          builder: (context) => SentenceSettingAdditionScreen(
              dictionary: dictionary, keyword: keyword));
    }

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      height: height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 16),
            SentenceSettingHeading(
                keyword: keyword, additionPressed: additionPressed),
            const SizedBox(height: 16),
            SentenceSettingListView(keyword: keyword, dictionary: dictionary),
            // 例文の追加ボタン
            SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  backgroundColor: Colors.green,
                ),
                onPressed: additionPressed,
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(
                  t.sentences.add,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
