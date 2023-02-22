import 'package:booqs_mobile/consts/language.dart';
import 'package:flutter/material.dart';

class WordFormReading extends StatelessWidget {
  const WordFormReading(
      {Key? key,
      required this.readingController,
      required this.langNumberOfEntry})
      : super(key: key);
  final TextEditingController readingController;
  final int langNumberOfEntry;

  @override
  Widget build(BuildContext context) {
    if (langNumberOfEntry != languageCodeMap['ja']) {
      return Container();
    }
    return Column(children: [
      const SizedBox(height: 24),
      TextFormField(
        controller: readingController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "読み（ひらがな）",
            hintText: '項目名の読みをひらがなで入力してください。'),
        validator: (value) {
          if (value!.isEmpty) {
            return 'このフォームは空欄にできません。';
          }
          return null;
        },
      ),
    ]);
  }
}
