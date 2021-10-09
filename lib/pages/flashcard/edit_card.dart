import 'package:booqs_mobile/models/flashcard_card.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/widgets/flashcard/flashcard_card_form.dart';
import 'package:flutter/material.dart';

class EditFlashcardCardPage extends StatelessWidget {
  const EditFlashcardCardPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, FlashcardCard flashcardCard) async {
    return Navigator.of(context).pushNamed(
      '/flashcard/edit-card',
      arguments: flashcardCard,
    );
  }

  @override
  Widget build(BuildContext context) {
    FlashcardCard getFlashcardCard() {
      return ModalRoute.of(context)!.settings.arguments as FlashcardCard;
    }

    Future update(String question, String answer) async {
      Navigator.of(context).pop();
    }

    Future delete() async {
      if (!await Dialogs.confirm(context, '削除', '削除してよろしいですか？')) {
        return;
      }
      //wait FlashcardCardRepository.delete(getFlashcardCard().id!);
      Navigator.of(context).pop();
    }

    final flashcardCard = getFlashcardCard();

    return Scaffold(
      appBar: AppBar(
        title: const Text('カードを編集'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: <Widget>[
              FlashcardCardForm(
                flashcardCard: flashcardCard,
                buttonText: '更新する',
              ),
              Container(
                margin: const EdgeInsets.only(top: 80),
                child: TextButton(
                  onPressed: delete,
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).errorColor,
                  ),
                  child: const Text('削除'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
