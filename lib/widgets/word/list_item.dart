import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/widgets/review/large_setting_button.dart';
import 'package:booqs_mobile/widgets/word/edit_button.dart';
import 'package:booqs_mobile/widgets/word/item/entry.dart';
import 'package:booqs_mobile/widgets/word/item/meaning.dart';
import 'package:booqs_mobile/widgets/word/item/reading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordListItem extends ConsumerWidget {
  const WordListItem({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget _reviewButton() {
      final Quiz? quiz = word.quiz;
      if (quiz == null) return const Text('Quiz does not exist.');
      final Review? review = word.review;
      return ReviewLargeSettingButton(quizId: quiz.id, review: review);
    }

    Widget _ipa() {
      if (word.ipa == null || word.ipa == '') {
        return Container();
      }
      return Text('${word.ipa}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.green.shade700,
          ));
    }

    Widget _content() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            WordItemEntry(word: word),
            WordItemReading(word: word),
            _ipa(),
            const SizedBox(
              height: 10,
            ),
            WordItemMeaning(word: word),
            const SizedBox(
              height: 24,
            ),
            _reviewButton(),
            WordEditButton(
              word: word,
              isShow: false,
            ),
          ]);
    }

    return InkWell(
      onTap: () {
        ref.read(wordProvider.notifier).state = word;
        WordShowPage.push(context, word.id);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24), child: _content()),
    );
  }
}
