import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/markdown_with_diqt_link.dart';
import 'package:flutter/material.dart';

class QuizExplanationDistractors extends StatelessWidget {
  const QuizExplanationDistractors({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    if (quiz.distractor1 == '' || quiz.distractor1 == null) {
      return Container();
    }
    final int? _dictionaryId = quiz.dictionaryId;

    Widget _distractor(distractor) {
      final Widget markdown = MarkdownWithDiQtLink(
          text: distractor,
          dictionaryId: _dictionaryId,
          textStyle: const TextStyle(fontSize: 16, color: Colors.red));

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
            child: markdown,
          ),
        ],
      );
    }

    // 選択肢（distracorsWidget）を作成する
    final List<String> answerTextList = [
      quiz.distractor1 ?? '',
      quiz.distractor2 ?? '',
      quiz.distractor3 ?? ''
    ];
    answerTextList.removeWhere((element) => element == '');
    final List<Widget> widgetList = [];
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
