import 'package:booqs_mobile/components/word_request/item/details_button.dart';
import 'package:booqs_mobile/components/word_request/item/main_content.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/widgets.dart';

class WordRequestAcceptedItem extends StatelessWidget {
  const WordRequestAcceptedItem({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        WordRequestItemMainContent(
          wordRequest: wordRequest,
        ),
        WordRequestItemDetailsButton(
          wordRequest: wordRequest,
        ),
      ],
    );
  }
}
