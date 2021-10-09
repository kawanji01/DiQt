import 'package:booqs_mobile/models/flashcard_card.dart';
import 'package:flutter/material.dart';

class FlashcardCardForm extends StatelessWidget {
  FlashcardCardForm({
    Key? key,
    this.buttonText = 'カードを追加',
    FlashcardCard? flashcardCard,
  })  : _questionController =
            TextEditingController(text: flashcardCard?.entry ?? ''),
        _answerController =
            TextEditingController(text: flashcardCard?.meaning ?? ''),
        super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController;
  final TextEditingController _answerController;
  final String buttonText;

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
