import 'package:booqs_mobile/models/flashcard.dart';
import 'package:booqs_mobile/widgets/flashcard/flashcard_form.dart';
import 'package:flutter/material.dart';

class FlashcardEditDialog extends StatefulWidget {
  // パラメーターを設定する / https://note.com/ohbashunsuke/n/n48e2d58c3486
  final String flashcardTitle;
  const FlashcardEditDialog({Key? key, required this.flashcardTitle})
      : super(key: key);
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
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // パラメーターをフォームに表示する。
      _nameController.text = widget.flashcardTitle;
    });
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('単語帳を編集'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlashcardForm(nameController: _nameController),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text('更新'),
        ),
      ],
    );
  }
}
