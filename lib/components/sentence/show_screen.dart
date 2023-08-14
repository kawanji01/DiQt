import 'package:booqs_mobile/components/dictionary/name.dart';
import 'package:booqs_mobile/components/drill/list_quiz.dart';
import 'package:booqs_mobile/components/sentence/list_item.dart';
import 'package:booqs_mobile/components/sentence/sentence_requests_button.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter/material.dart';

class SentenceShowScreen extends StatelessWidget {
  const SentenceShowScreen({super.key, required this.sentence});
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    Widget quiz(Sentence sentence) {
      final Quiz? quiz = sentence.quiz;
      if (quiz == null) return Container();
      return DrillListQuiz(
        quiz: quiz,
        isShow: false,
      );
    }

    Widget reversedQuiz(Sentence sentence) {
      final Quiz? quiz = sentence.reversedQuiz;
      if (quiz == null) return Container();
      return DrillListQuiz(
        quiz: quiz,
        isShow: false,
      );
    }

    final Dictionary? dictionary = sentence.dictionary;
    if (dictionary == null) return const Text('Dictionary does not exist.');
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          DictionaryName(dictionary: dictionary, linked: true),
          const SizedBox(height: 24),
          SentenceListItem(
            sentence: sentence,
            isShow: true,
          ),
          SentenceSentenceRequestsButton(sentence: sentence),
          const SizedBox(height: 24),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(height: 16),
          quiz(sentence),
          reversedQuiz(sentence),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
