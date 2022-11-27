import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/dictionary/show.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class WordFormDestroyConfirmationScreen extends StatelessWidget {
  const WordFormDestroyConfirmationScreen({Key? key, required this.word})
      : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    const heading = Text('削除確認',
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87));

    const explanation = Text('この項目の削除申請を行います。よろしいですか？',
        style: TextStyle(fontSize: 16, color: Colors.black87));

    Future submit() async {
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteWords.destroy(word.id);
      EasyLoading.dismiss();
      if (resMap == null) return;
      final snackBar = SnackBar(content: Text(resMap['message']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      if (resMap['word'] == null) {
        DictionaryShowPage.push(context, word.dictionaryId);
      } else {
        WordShowPage.push(context, word.id);
      }
    }

    final submitButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        minimumSize: const Size(double.infinity,
            40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
      ),
      onPressed: () {
        submit();
      },
      icon: const Icon(Icons.delete, color: Colors.white),
      label: const Text(
        '削除する',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
      ),
    );

    return Container(
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading,
          const SizedBox(height: 16),
          explanation,
          const SizedBox(height: 32),
          submitButton
        ],
      )),
    );
  }
}
