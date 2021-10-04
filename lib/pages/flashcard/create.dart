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
                    TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: '名前',
                          hintText: '名前',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return '入力してください';
                          }
                          return null;
                        }),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: _save,
                        child: const Text('登録'),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
