import 'package:flutter/material.dart';

class QuizFormDistractor extends StatelessWidget {
  const QuizFormDistractor(
      {Key? key, required this.distractorController, required this.number})
      : super(key: key);
  final TextEditingController distractorController;
  final int number;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 2,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: distractorController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: '誤りの選択肢 ($number)',
        hintText: '【空欄可】誤りの選択肢があれば入力してください。',
      ),
    );
  }
}
