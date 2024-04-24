import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/speech_test.dart';
import 'package:flutter/material.dart';

class SpeechTestButton extends StatelessWidget {
  const SpeechTestButton({super.key, required this.dictionary});
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // icon: const Icon(Icons.manage_search), // 使用するアイコンを指定
      icon: const Icon(Icons.mic_none),
      onPressed: () {
        // ボタンがタップされたときのアクション
        // キーボードを閉じる
        FocusScopeNode currentFocus = FocusScope.of(context);
        // フォーカスがすでにない状況でunfocus()を呼び出すと、エラーが発生する可能性がある
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        DictionarySpeechTestPage.push(context, dictionary);
      },
      color: Colors.black87, // アイコンの色を指定（オプション）
      tooltip: 'SpeechTestButton', // 長押し時に表示されるツールチップ（オプション）
    );
  }
}
