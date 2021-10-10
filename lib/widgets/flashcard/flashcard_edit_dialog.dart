import 'package:booqs_mobile/models/flashcard.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/widgets/flashcard/flashcard_form.dart';
import 'package:flutter/material.dart';

class FlashcardEditDialog extends StatefulWidget {
  // パラメーターを設定する / https://note.com/ohbashunsuke/n/n48e2d58c3486
  //final String flashcardTitle;
  const FlashcardEditDialog({Key? key, required this.flashcard})
      : super(key: key);
  final Flashcard flashcard;
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

  Future _delete() async {
    if (!await Dialogs.confirm(context, '削除', '削除してよろしいですか？')) {
      return;
    }
    const snackBar = SnackBar(content: Text('削除しました'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // 最初の画面まで戻る
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // パラメーターをフォームに表示する。
      _nameController.text = widget.flashcard.title;
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
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: _delete,
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).errorColor,
                  ),
                  child: const Text('削除'),
                )),
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
