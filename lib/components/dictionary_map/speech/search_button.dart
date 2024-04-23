import 'dart:io';

import 'package:booqs_mobile/components/dictionary_map/speech/search_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';

class DictionaryMapSpeechSearchButton extends StatelessWidget {
  const DictionaryMapSpeechSearchButton(
      {super.key, required this.keywordController, required this.dictionary});
  final TextEditingController keywordController;
  final Dictionary? dictionary;

  @override
  Widget build(BuildContext context) {
    // Androidだと音声認識がない場合があるので表示しない。
    if (Platform.isAndroid) {
      return Container();
    }
    if (dictionary == null) {
      IconButton(
          // icon: const Icon(Icons.manage_search), // 使用するアイコンを指定
          icon: const Icon(Icons.mic_none),
          color: Colors.black54, // アイコンの色を指定（オプション）
          tooltip: t.dictionaryMaps.search_by_speech, // 長押し時に表示されるツールチップ（オプション）
          onPressed: () {});
    }

    Widget content() {
      if (dictionary == null) {
        return Text(t.dictionaryMaps.please_select);
      }
      return DictionaryMapSpeechSearchScreen(
        dictionary: dictionary!,
        keywordController: keywordController,
      );
    }

    return IconButton(
      // icon: const Icon(Icons.manage_search), // 使用するアイコンを指定
      icon: const Icon(Icons.mic),
      color: Colors.black87, // アイコンの色を指定（オプション）
      tooltip: t.dictionaryMaps.search_by_speech, // 長押し時に表示されるツールチップ（オプション）
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
            return SingleChildScrollView(
              // Another exception was thrown: RenderFlex children have non-zero flex but incoming height constraints are unbounded.対策に
              // SingleChildScrollViewとColumnの間にContainerを入れる
              child: Container(
                height: ResponsiveValues.dialogHeight(context),
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveValues.horizontalMargin(context)),
                child: content(),
              ),
            );
          },
        );
      },
    );
  }
}
