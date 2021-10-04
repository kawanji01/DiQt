import 'package:flutter/material.dart';

class CreateFlashcardPage extends StatefulWidget {
  const CreateFlashcardPage({Key? key}) : super(key: key);

  @override
  _CreateFlashcardPageState createState() => _CreateFlashcardPageState();
}

class _CreateFlashcardPageState extends State<CreateFlashcardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('単語帳を作成'),
      ),
      body: Column(
        children: <Widget>[const Text('新規登録画面')],
      ),
    );
  }
}
