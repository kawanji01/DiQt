import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/dictionary/quiz_requests_button.dart';
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
        const Text('問題集',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 16,
        ),
        DictionaryQuizRequestsButton(dictionary: dictionary),
      ],
    );
  }
}
