import 'package:booqs_mobile/widgets/flashcard/flashcard_form.dart';
import 'package:flutter/material.dart';

class CreateFlashcardPage extends StatefulWidget {
  const CreateFlashcardPage({Key? key}) : super(key: key);

  @override
  _CreateFlashcardPageState createState() => _CreateFlashcardPageState();
}

class _CreateFlashcardPageState extends State<CreateFlashcardPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    print('ok');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('単語帳を作成'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  FlashcardForm(nameController: _nameController),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: _save,
                      child: const Text('登録'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
