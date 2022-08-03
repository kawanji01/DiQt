import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class QuizFormPreviewDistractors extends StatelessWidget {
  const QuizFormPreviewDistractors(
      {Key? key,
      required this.distractor1,
      required this.distractor2,
      required this.distractor3,
      required this.dictionaryId,
      required this.langNumberOfAnswer,
      required this.autoDictLinkOfAnswer})
      : super(key: key);
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

    Widget _autoLink(String distractor) {
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
            ),
          ),
        ],
      );
    }

    Widget _markdown(String distractor) {
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
              textStyle: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
        ],
      );
    }

    Widget _distractor(String distractor) {
      if (distractor == '') {
        return Container();
      }
      Widget distractorWidget;
      if (autoDictLinkOfAnswer) {
        distractorWidget = _autoLink(distractor);
      } else {
        distractorWidget = _markdown(distractor);
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
        const SharedItemLabel(text: '誤りの選択肢'),
        const SizedBox(
          height: 16,
        ),
        _distractor(distractor1),
        _distractor(distractor2),
        _distractor(distractor3)
      ],
    );
  }
}
