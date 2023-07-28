import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:booqs_mobile/pages/word_request/show.dart';
import 'package:flutter/material.dart';

class WordRequestItemFooter extends StatelessWidget {
  const WordRequestItemFooter({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        // 詳細
        TextButton(
            onPressed: () {
              WordRequestShowPage.push(context, wordRequest.id);
            },
            child: Text(t.shared.details,
                style: const TextStyle(fontSize: 14, color: Colors.black54))),
      ],
    );
  }
}
