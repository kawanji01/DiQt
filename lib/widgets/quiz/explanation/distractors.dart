import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/markdown_with_diqt_link.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
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

    // 選択肢のテキスト
    Widget _distractorContent(String distractor) {
      if (quiz.autoDictLinkOfAnswer) {
        return TextWithDictLink(
          text: distractor,
          langNumber: quiz.langNumberOfAnswer,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          dictionaryId: quiz.dictionaryId,
        );
      }
      return MarkdownWithDiQtLink(
          text: distractor,
          dictionaryId: _dictionaryId,
          textStyle: const TextStyle(fontSize: 16, color: Colors.red));
    }

    // 実際の選択肢
    Widget _distractor(String distractor) {
      return Container(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Icon(Icons.close, color: Colors.red, size: 24),
            ),
            // Expandedを使うと短い文章でも幅全体を埋めてしまい、結果的に左寄せになってしまうので Flexible を使う。
            Flexible(
              child: _distractorContent(distractor),
            ),
          ],
        ),
      );
    }

    // 選択肢のリスト
    List<Widget> _distractorWidgetList() {
      final List<Widget> widgetList = [];
      final List<String> answerTextList = [
        quiz.distractor1 ?? '',
        quiz.distractor2 ?? '',
        quiz.distractor3 ?? ''
      ];
      answerTextList.removeWhere((element) => element == '');
      answerTextList.asMap().forEach((int i, String value) {
        widgetList.add(_distractor(value));
      });
      return widgetList;
    }

    return Column(children: <Widget>[
      const SharedItemLabel(text: '誤りの選択肢'),
      const SizedBox(
        height: 16,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _distractorWidgetList(),
      ),
      const SizedBox(
        height: 24,
      ),
    ]);
  }
}
