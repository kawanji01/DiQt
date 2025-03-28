import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class QuizFormPreviewDistractors extends StatelessWidget {
  const QuizFormPreviewDistractors(
      {super.key,
      required this.distractor1,
      required this.distractor2,
      required this.distractor3,
      required this.dictionaryId,
      required this.langNumberOfAnswer,
      required this.autoDictLinkOfAnswer});
  final String distractor1;
  final String distractor2;
  final String distractor3;
  final int? dictionaryId;
  final int langNumberOfAnswer;
  final bool autoDictLinkOfAnswer;

  @override
  Widget build(BuildContext context) {
    if (distractor1 == '') {
      return Container();
    }

    Widget autoLink(String distractor) {
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
            child: TextWithDictLink(
              text: distractor,
              langNumber: langNumberOfAnswer,
              dictionaryId: dictionaryId,
              autoLinkEnabled: true,
              crossAxisAlignment: CrossAxisAlignment.start,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontColor: Colors.red,
              selectable: true,
            ),
          ),
        ],
      );
    }

    Widget markdown(String distractor) {
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
            child: MarkdownWithDictLink(
              text: distractor,
              dictionaryId: dictionaryId,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontColor: Colors.red,
              selectable: true,
            ),
          ),
        ],
      );
    }

    Widget distractor(String distractor) {
      if (distractor == '') {
        return Container();
      }
      Widget distractorWidget;
      if (autoDictLinkOfAnswer) {
        distractorWidget = autoLink(distractor);
      } else {
        distractorWidget = markdown(distractor);
      }
      return Column(
        children: [
          distractorWidget,
          const SizedBox(
            height: 8,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(text: t.quizzes.distractors),
        const SizedBox(
          height: 16,
        ),
        distractor(distractor1),
        distractor(distractor2),
        distractor(distractor3)
      ],
    );
  }
}
