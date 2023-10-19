import 'package:booqs_mobile/components/dictionary_map/image/search_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';

class DictionaryMapImageSearchButton extends StatelessWidget {
  const DictionaryMapImageSearchButton(
      {super.key, required this.keywordController, required this.dictionary});
  final TextEditingController keywordController;
  final Dictionary? dictionary;

  @override
  Widget build(BuildContext context) {
    if (dictionary == null) {
      IconButton(
          // icon: const Icon(Icons.manage_search), // 使用するアイコンを指定
          icon: const Icon(Icons.image_search),
          color: Colors.black54, // アイコンの色を指定（オプション）
          tooltip: t.dictionaryMaps.search_by_image, // 長押し時に表示されるツールチップ（オプション）
          onPressed: () {});
    }

    Widget content() {
      if (dictionary == null) {
        return Text(t.dictionaryMaps.please_select);
      }
      return DictionaryMapImageSearchScreen(
        keywordController: keywordController,
        dictionary: dictionary!,
      );
    }

    return IconButton(
      icon: const Icon(Icons.image_search_outlined),
      color: Colors.black87, // アイコンの色を指定（オプション）
      tooltip: t.dictionaryMaps.search_by_image, // 長押し時に表示されるツールチップ（オプション）
      onPressed: () {
        // ボタンがタップされたときのアクション
        // キーボードを閉じる
        FocusScopeNode currentFocus = FocusScope.of(context);
        // フォーカスがすでにない状況でunfocus()を呼び出すと、エラーが発生する可能性がある
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
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
          builder: (context) {
            return Container(
              height: ResponsiveValues.dialogHeight(context),
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveValues.horizontalMargin(context)),
              child: SingleChildScrollView(
                child: content(),
              ),
            );
          },
        );
      },
    );
  }
}
