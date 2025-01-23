import 'package:booqs_mobile/components/chapter/show.dart';
import 'package:booqs_mobile/components/heading/large_green.dart';
import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/word_tag.dart';
import 'package:flutter/material.dart';

class WordTagShowScreen extends StatelessWidget {
  const WordTagShowScreen({super.key, required this.wordTag});
  final WordTag? wordTag;

  @override
  Widget build(BuildContext context) {
    if (wordTag == null) return const Text('Word tag does not exist.');

    Widget chapter() {
      final Chapter? chapter = wordTag?.chapter;
      if (chapter == null) return Container();

      return ChapterShow(
        chapter: chapter,
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      HeadingLargeGreen(label: wordTag?.name ?? ''),
      const SizedBox(
        height: 24,
      ),
      MarkdownWithDictLink(
        text: wordTag?.introduction ?? '',
        dictionaryId: wordTag?.dictionaryId,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontColor: Colors.black87,
        selectable: true,
      ),
      const SizedBox(height: 48),
      chapter(),
      const SizedBox(
        height: 120,
      ),
    ]);
  }
}
