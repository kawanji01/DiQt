import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SentenceFormKeyword extends StatelessWidget {
  const SentenceFormKeyword({super.key, required this.keywordController});
  final TextEditingController keywordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(t.sentences.keyword_description(limit: 50),
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.normal)),
        const SizedBox(height: 16),
        TextFormField(
          controller: keywordController,
          decoration: InputDecoration(
            labelText: t.sentences.keyword_placeholder,
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                keywordController.clear();
              },
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }
            return null;
          },
        ),
      ],
    );
  }
}
