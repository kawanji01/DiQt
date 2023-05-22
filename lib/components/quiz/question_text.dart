import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/markdown/markdown_without_dict_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizQuestionText extends ConsumerStatefulWidget {
  const QuizQuestionText({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  QuizQuestionTextState createState() => QuizQuestionTextState();
}

class QuizQuestionTextState extends ConsumerState<QuizQuestionText> {
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
        child: MarkdownWithoutDictLink(
          fontColor: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          selectable: false,
          text: quiz.question,
        ));
  }
}
