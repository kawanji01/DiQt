import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/widgets.dart';

class WordRequestRejectedItem extends StatelessWidget {
  const WordRequestRejectedItem({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    return const Text('Rejected Requests');
  }
}
