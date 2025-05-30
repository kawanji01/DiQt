import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/models/word_tag.dart';
import 'package:booqs_mobile/pages/word_tag/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WordItemWordTags extends ConsumerWidget {
  const WordItemWordTags({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<WordTag>? wordTags = word.wordTags;
    if (wordTags == null) {
      return Container();
    }
    if (wordTags.isEmpty) {
      return Container();
    }

    // タグボタン
    Widget tagButton(WordTag wordTag) {
      return InkWell(
        onTap: () {
          WordTagShowPage.push(context, wordTag.id);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          margin: const EdgeInsets.only(left: 8, bottom: 8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            border: Border.all(color: Colors.black54, width: 1),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
              children: [
                const WidgetSpan(
                  child: FaIcon(
                    FontAwesomeIcons.tag,
                    size: 12,
                    color: Colors.black54,
                  ),
                ),
                TextSpan(
                  text: " ${wordTag.name}",
                ),
              ],
            ),
          ),
        ),
      );
    }

    // タグのボタン（複数）を作成する
    List<Widget> createTags() {
      List<Widget> tagWidgets = <Widget>[];
      for (WordTag tag in wordTags) {
        tagWidgets.add(tagButton(tag));
      }
      return tagWidgets;
    }

    // タグを右揃えに並べて返す。
    return Container(
      alignment: Alignment.centerRight,
      child: Wrap(alignment: WrapAlignment.end, children: createTags()),
    );
  }
}
