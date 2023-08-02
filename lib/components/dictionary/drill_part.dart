import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/dictionary/quiz_requests_button.dart';
import 'package:flutter/material.dart';

class DictionaryDrillPart extends StatelessWidget {
  const DictionaryDrillPart({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.drills.drills,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 16,
        ),
        DictionaryQuizRequestsButton(dictionary: dictionary),
      ],
    );
  }
}
