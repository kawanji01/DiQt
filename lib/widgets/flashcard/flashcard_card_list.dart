import 'package:booqs_mobile/models/flashcard_card.dart';
import 'package:flutter/material.dart';

class FlashcardCardList extends StatelessWidget {
  const FlashcardCardList({Key? key, required this.flashcardCards})
      : super(key: key);
  final List<FlashcardCard> flashcardCards;

  Widget _buildRow(int index) {
    final flashcardCard = flashcardCards[index];

    return ListTile(
      title: Text(flashcardCard.entry),
      subtitle: Text(flashcardCard.meaning),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => _buildRow(index),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: flashcardCards.length,
    );
  }
}
