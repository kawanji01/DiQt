import 'package:flutter/material.dart';

class NoteFormField extends StatelessWidget {
  const NoteFormField({Key? key, required this.noteContentController})
      : super(key: key);
  final TextEditingController noteContentController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: noteContentController,
      minLines: 4,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: const TextStyle(color: Colors.black87),
      decoration: const InputDecoration(
        filled: true,
        border: InputBorder.none,
        fillColor: Color(0xfff3f3f4),
        labelText: "問題に関する自分用のメモ",
        labelStyle: TextStyle(color: Colors.black54),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '空欄のノートは作成できません。';
        }
        return null;
      },
    );
  }
}
