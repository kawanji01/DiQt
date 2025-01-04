import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SentenceSettingHeading extends StatelessWidget {
  const SentenceSettingHeading(
      {super.key, required this.keyword, required this.additionPressed});
  final String keyword;
  final VoidCallback additionPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Text('"$keyword" / ', style: const TextStyle(fontSize: 12)),
      // 例文の取り消しボタン
      TextButton(
        style: ButtonStyle(
          // paddingを消す
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          minimumSize: WidgetStateProperty.all(Size.zero),
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
      ),
      // 例文の追加ボタン
      TextButton(
        style: ButtonStyle(
          // paddingを消す
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          minimumSize: WidgetStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: additionPressed,
        child: Text(' / ${t.sentences.add}',
            style: const TextStyle(
              color: Colors.green,
              fontSize: 12,
            )),
      ),
    ]);
  }
}
