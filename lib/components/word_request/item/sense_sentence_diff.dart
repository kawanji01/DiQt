import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/word_request/item/sentence_diff.dart';
import 'package:booqs_mobile/data/remote/word_requests.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/widgets.dart';

class WordRequestItemSenseSentenceDiff extends StatefulWidget {
  const WordRequestItemSenseSentenceDiff(
      {super.key, required this.sentenceId, required this.previousSentenceId});
  final int? sentenceId;
  final int? previousSentenceId;

  @override
  State<WordRequestItemSenseSentenceDiff> createState() =>
      _WordRequestItemSenseSentenceDiffState();
}

class _WordRequestItemSenseSentenceDiffState
    extends State<WordRequestItemSenseSentenceDiff> {
  bool _isLoading = true;
  Sentence? _sentence;
  Sentence? _previousSentence;

  @override
  void initState() {
    super.initState();
    _loadSentences();
  }

  Future<void> _loadSentences() async {
    final Map resMap = await RemoteWordRequests.sentences(
        sentenceId: widget.sentenceId,
        previousSentenceId: widget.previousSentenceId);
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorSnackBar(context, resMap);
      return;
    }
    if (resMap['sentence'] != null) {
      _sentence = Sentence.fromJson(resMap['sentence']);
    }
    if (resMap['previous_sentence'] != null) {
      _previousSentence = Sentence.fromJson(resMap['previous_sentence']);
    }
    setState(() {
      _sentence;
      _previousSentence;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingSpinner();
    }
    return WordRequestItemSentenceDiff(
        sentence: _sentence, previousSentence: _previousSentence);
  }
}
