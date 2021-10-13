import 'package:booqs_mobile/models/word.dart';
//import 'package:booqs_mobile/pages/flashcard/edit_card.dart';
import 'package:flutter/material.dart';

class WordList extends StatelessWidget {
  const WordList({Key? key, required this.words}) : super(key: key);
  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    //Future goToEdit(words flashcardCard) async {
    //  await EditFlashcardCardPage.push(context, flashcardCard);
    //}

    Widget _buildRow(int index) {
      final flashcardCard = words[index];

      return ListTile(
        title: Text(flashcardCard.entry),
        subtitle: Text(flashcardCard.meaning),
        //onTap: () => goToEdit(flashcardCard),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) => _buildRow(index),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: words.length,
    );
  }
}
