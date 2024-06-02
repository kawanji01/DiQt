import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/markdown/markdown_without_dict_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizItemQuestionText extends ConsumerStatefulWidget {
  const QuizItemQuestionText({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  QuizItemQuestionTextState createState() => QuizItemQuestionTextState();
}

class QuizItemQuestionTextState extends ConsumerState<QuizItemQuestionText> {
  bool _isCovered = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isCovered = ref.read(questionCoveredProvider);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Quiz quiz = widget.quiz;
    if (quiz.questionHidden) {
      return Container();
    }

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
            text: TextSpan(children: [
          const WidgetSpan(
            child: Icon(
              Icons.lock,
              color: Colors.green,
              size: 18.0,
            ),
          ),
          TextSpan(
              text: ' ${t.quizzes.question_cover_text}',
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 1,
                  fontWeight: FontWeight.bold))
        ])),
      ),
    );

    if (_isCovered && quiz.questionReadAloud) {
      return cover;
    }
    return SizedBox(
        width: double.infinity,
        child: MarkdownWithoutDictLink(
          fontColor: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.normal,
          selectable: true,
          text: quiz.question,
        ));
  }
}
