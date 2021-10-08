import 'package:booqs_mobile/models/flashcard.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/flashcard/flashcard_card_form.dart';
import 'package:booqs_mobile/widgets/flashcard/flashcard_form.dart';
import 'package:flutter/material.dart';

class EditFlashcardPage extends StatefulWidget {
  const EditFlashcardPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, Flashcard flashcard) async {
    return Navigator.of(context)
        .pushNamed(flashcardEditPage, arguments: flashcard);
  }

  @override
  _EditFlashcardPageState createState() => _EditFlashcardPageState();
}

class _EditFlashcardPageState extends State<EditFlashcardPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  late Flashcard _flashcard;

  Future _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    const snackBar = SnackBar(content: Text('名前を更新しました。'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    // initialize
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // パラメーターを受け取る。型をFlashcardにキャスト。
      final flashcard = ModalRoute.of(context)!.settings.arguments as Flashcard;
      _nameController.text = flashcard.title;
      setState(() {
        _flashcard = flashcard;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('単語帳を編集'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                          child: const Text('更新'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          'カードを追加',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      FlashcardCardForm(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
