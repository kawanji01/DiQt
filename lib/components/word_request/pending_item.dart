import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/widgets.dart';

class WordRequestPendingItem extends StatelessWidget {
  const WordRequestPendingItem({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    return const Text('Pending Requests');
  }
}
