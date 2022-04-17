import 'package:booqs_mobile/routes.dart';
import 'package:flutter/material.dart';

class AnswerSettingEdit extends StatelessWidget {
  const AnswerSettingEdit({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(answerSettingEdit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('解答・復習設定'),
      ),
      body: Container(),
    );
  }
}
