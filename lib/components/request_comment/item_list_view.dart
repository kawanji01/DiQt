import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/widgets.dart';

class RequestCommentItemListView extends StatefulWidget {
  const RequestCommentItemListView(
      {super.key, this.wordRequest, this.sentenceRequest, this.quizRequest});
  final WordRequest? wordRequest;
  final SentenceRequest? sentenceRequest;
  final QuizRequest? quizRequest;

  @override
  State<RequestCommentItemListView> createState() =>
      _RequestCommentItemListViewState();
}

class _RequestCommentItemListViewState
    extends State<RequestCommentItemListView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
