import 'package:booqs_mobile/models/flashcard.dart';
import 'package:booqs_mobile/widgets/flashcard/flashcard_form.dart';
import 'package:flutter/material.dart';

class FlashcardEditDialog extends StatefulWidget {
  const FlashcardEditDialog({Key? key, Flashcard? flashcard}) : super(key: key);

  @override
  _FlashcardEditDialogState createState() => _FlashcardEditDialogState();
}

class _FlashcardEditDialogState extends State<FlashcardEditDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  Future _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Navigator.of(context).pop(_nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('単語帳を編集'),
      content: Form(
          key: _formKey,
          child: Column(
            // なるべくダイアログを小さくする
            mainAxisSize: MainAxisSize.min,
            children: [
              FlashcardForm(nameController: _nameController),
            ],
          )),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(onPressed: _save, child: const Text('更新'))
      ],
    );
  }
}
