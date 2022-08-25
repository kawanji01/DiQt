import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/word/item/label.dart';
import 'package:flutter/material.dart';

class WordItemReading extends StatelessWidget {
  const WordItemReading({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    final String? reading = word.reading;
    if (reading == null ||
        reading == '' ||
        word.langNumberOfEntry != languageCodeMap['ja']) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          reading,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.green.shade700,
          ),
        ),
      ],
    );
  }
}
