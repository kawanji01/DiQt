import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  const SearchForm(
      {Key? key, required this.nameController, required this.focusNode})
      : super(key: key);
  final TextEditingController nameController;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      focusNode: focusNode,
      decoration: const InputDecoration(
        labelText: '検索ワード',
        hintText: '調べたい単語・熟語を入力してください',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '入力してください。';
        }
        return null;
      },
    );
  }
}
