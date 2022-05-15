import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/sentence/item_with_review_button.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/word/tile.dart';
import 'package:flutter/material.dart';

class QuizSource extends StatefulWidget {
  const QuizSource({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  State<QuizSource> createState() => _QuizSourceState();
}

class _QuizSourceState extends State<QuizSource> {
  bool _isLoading = true;
  Word? _word;
  Sentence? _sentence;
  @override
  void initState() {
    super.initState();
    final Quiz quiz = widget.quiz;
    _loadSource(quiz);
  }

  Future _loadSource(Quiz quiz) async {
    // そもそもソースがなければ早期リターン
    if (quiz.wordId == null &&
        quiz.referenceWordId == null &&
        quiz.sentenceId == null) {
      return setState(() => _isLoading = false);
    }
    // ソースを取得
    final Map? resMap = await RemoteQuizzes.source(quiz.id);
    _isLoading = false;
    if (resMap == null) {
      return setState(() => _isLoading);
    }
    final Word? word =
        resMap['word'] == null ? null : Word.fromJson(resMap['word']);
    final Sentence? sentence = resMap['sentence'] == null
        ? null
        : Sentence.fromJson(resMap['sentence']);
    if (mounted) {
      setState(() {
        _word = word;
        _sentence = sentence;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const LoadingSpinner();
    if (_word == null && _sentence == null) return Container();

    Widget _wordSource() {
      if (_word == null) return Container();
      return Column(children: [
        const SharedItemLabel(text: '辞書'),
        const SizedBox(height: 16),
        WordTile(word: _word!),
        const SizedBox(height: 40),
      ]);
    }

    Widget _sentenceSource() {
      if (_sentence == null) return Container();
      return Column(children: [
        const SharedItemLabel(text: '例文'),
        const SizedBox(height: 16),
        SentenceItemWithReviewButton(
          sentence: _sentence!,
          isShow: false,
        ),
        const SizedBox(height: 40),
      ]);
    }

    return Column(
      children: [_wordSource(), _sentenceSource()],
    );
  }
}
