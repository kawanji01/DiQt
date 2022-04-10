import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/text_with_link.dart';
import 'package:flutter/material.dart';

class QuizExplanationDistractors extends StatelessWidget {
  const QuizExplanationDistractors({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    if (quiz.distractors == '' || quiz.distractors == null) {
      return Container();
    }

    Widget _distractor(distractor) {
      Widget child;
      if (quiz.langNumberOfAnswer! == languageCodeMap['en']) {
        child = TextWithLink(
          text: distractor,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.start,
        );
      }
      child = Text(distractor,
          style: const TextStyle(fontSize: 16, color: Colors.red));

      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: const Icon(Icons.close, color: Colors.red, size: 24),
          ),
          // Expandedを使うと短い文章でも幅全体を埋めてしまい、結果的に左寄せになってしまうので Flexible を使う。
          Flexible(
            child: child,
          ),
        ],
      );
    }

    final List<String> answerTextList = quiz.distractors!.split('\n');
    List<Widget> widgetList = [];
    answerTextList.asMap().forEach((int i, String value) {
      widgetList.add(
        Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: _distractor(value)),
      );
    });
    final Widget distracorsWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgetList,
    );

    return Column(children: <Widget>[
      const SharedItemLabel(text: '誤りの選択肢'),
      const SizedBox(
        height: 16,
      ),
      distracorsWidget,
      const SizedBox(
        height: 24,
      ),
    ]);
  }
}
