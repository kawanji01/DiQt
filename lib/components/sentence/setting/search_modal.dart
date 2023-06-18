import 'package:booqs_mobile/components/sentence/setting/list_view.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/sentence/new.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';

class SentenceSettingSearchModal extends StatelessWidget {
  const SentenceSettingSearchModal(
      {Key? key, required this.keyword, required this.dictionary})
      : super(key: key);
  final String keyword;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

    // 例文追加ボタン
    Widget buttonToAddSentence() {
      return SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () {
            SentenceNewPage.push(context, dictionary.id, keyword);
          },
          icon: const Icon(Icons.add, color: Colors.white),
          label: Text(
            t.sentences.add,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    // 例文の取り消しボタン
    Widget removeButton() {
      return TextButton(
        style: ButtonStyle(
          // paddingを消す
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          // 引数に{ 'set': null }を渡すことで、例文を取り消す
          return Navigator.of(context).pop({'set': null});
        },
        child: Text(t.sentences.remove,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            )),
      );
    }

    // ヘッダーの例文の追加ボタン
    Widget additionButton() {
      return TextButton(
        style: ButtonStyle(
          // paddingを消す
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          SentenceNewPage.push(context, dictionary.id, keyword);
        },
        child: Text(' / ${t.sentences.add}',
            style: const TextStyle(
              color: Colors.green,
              fontSize: 12,
            )),
      );
    }

    // 例文の取り消しボタン
    Widget heading() {
      return Wrap(children: [
        Text('"$keyword" / ', style: const TextStyle(fontSize: 12)),
        removeButton(),
        additionButton()
      ]);
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
            heading(),
            const SizedBox(height: 16),
            //_searchResults(),
            SentenceSettingListView(keyword: keyword, dictionary: dictionary),
            buttonToAddSentence(),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
