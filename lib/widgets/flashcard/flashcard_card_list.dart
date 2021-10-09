import 'package:booqs_mobile/models/flashcard_card.dart';
import 'package:booqs_mobile/pages/flashcard/edit_card.dart';
import 'package:flutter/material.dart';

class FlashcardCardList extends StatelessWidget {
  const FlashcardCardList({Key? key, required this.flashcardCards})
      : super(key: key);
  final List<FlashcardCard> flashcardCards;

  @override
  Widget build(BuildContext context) {
    Future goToEdit(FlashcardCard flashcardCard) async {
      await EditFlashcardCardPage.push(context, flashcardCard);
    }

    Widget _buildRow(int index) {
      final flashcardCard = flashcardCards[index];

      return ListTile(
        title: Text(flashcardCard.entry),
        subtitle: Text(flashcardCard.meaning),
        onTap: () => goToEdit(flashcardCard),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) => _buildRow(index),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: flashcardCards.length,
    );
  }
}
