import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/services/sanitizer.dart';
import 'package:booqs_mobile/utils/markdown/diqt_link_builder.dart';
import 'package:booqs_mobile/utils/markdown/diqt_link_syntax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizQuestionText extends ConsumerStatefulWidget {
  const QuizQuestionText({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  _QuizQuestionTextState createState() => _QuizQuestionTextState();
}

class _QuizQuestionTextState extends ConsumerState<QuizQuestionText> {
  bool _isCovered = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _isCovered = ref.watch(answerSettingProvider
            .select((setting) => setting?.questionCovered ?? false));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Quiz quiz = widget.quiz;
    // DiQtリンク（[[text1|text2]]など）を取り除いてplain textに直す。
    //final String question = Sanitizer.removeDiQtLink(quiz.question);
    //final Widget questionText = Text(
    //  question,
    //  style: const TextStyle(fontSize: 16),
    //);

    final Widget cover = InkWell(
      onTap: () {
        setState(() {
          _isCovered = false;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: RichText(
            text: const TextSpan(children: [
          WidgetSpan(
            child: Icon(
              Icons.lock,
              color: Colors.green,
              size: 18.0,
            ),
          ),
          TextSpan(
              text: ' タップして問題文を表示',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))
        ])),
      ),
    );

    if (_isCovered && quiz.questionReadAloud) {
      return cover;
    }
    return SizedBox(
      width: double.infinity,
      child: MarkdownBody(
        data: quiz.question,
        shrinkWrap: true,
        builders: <String, MarkdownElementBuilder>{
          'diqtlink': DiQtLinkBuilder(),
        },
        inlineSyntaxes: [DiQtLinkSyntax(quiz.dictionaryId)],
      ),
    );
  }
}
