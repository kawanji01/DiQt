import 'package:flutter/material.dart';

class FlashcardCardForm extends StatelessWidget {
  FlashcardCardForm({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  Future _save() async {}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _questionController,
            decoration: const InputDecoration(
              labelText: '質問',
              hintText: '質問',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return '入力してください。';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _answerController,
            decoration: const InputDecoration(
              labelText: '回答',
              hintText: '回答',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return '入力してください。';
              }
              return null;
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: _save,
              child: const Text('カードを追加'),
            ),
          ),
        ],
      ),
    );
  }
}
