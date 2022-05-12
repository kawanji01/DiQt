import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/sentence/new.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:booqs_mobile/widgets/dictionary/sentence_requests_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionarySentencePart extends ConsumerWidget {
  const DictionarySentencePart({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const heading = Text(
      '例文',
      style: TextStyle(
          fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold),
    );

    Widget _newSentenceButton() {
      return InkWell(
        onTap: () {
          SentenceNewPage.push(context, dictionary.id);
        },
        child: const SmallGreenButton(label: '例文を追加する', icon: Icons.add),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading,
        _newSentenceButton(),
        DictionarySentenceRequestsButton(dictionary: dictionary),
      ],
    );
  }
}
