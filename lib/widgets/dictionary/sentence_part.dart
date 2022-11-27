import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/sentence/new.dart';
import 'package:booqs_mobile/widgets/button/small_outline_gray_button.dart';
import 'package:booqs_mobile/widgets/dictionary/sentence_requests_button.dart';
import 'package:booqs_mobile/widgets/dictionary/sentence_search_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionarySentencePart extends ConsumerWidget {
  const DictionarySentencePart({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heading = Text(
      '例文（${dictionary.sentencesCount}）',
      style: const TextStyle(
          fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold),
    );

    Widget newSentenceButton() {
      return InkWell(
        onTap: () {
          SentenceNewPage.push(context, dictionary.id, '');
        },
        child: const SmallOutlineGrayButton(label: '例文を追加する', icon: Icons.add),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading,
        const SizedBox(height: 16),
        DictionarySentenceSearchForm(dictionary: dictionary),
        newSentenceButton(),
        DictionarySentenceRequestsButton(dictionary: dictionary),
      ],
    );
  }
}
