import 'package:booqs_mobile/widgets/markdown/embedded_sentence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class EmbeddedSentenceBuilder extends MarkdownElementBuilder {
  EmbeddedSentenceBuilder(this.fontSize, this.selectable) : super();
  final double fontSize;
  final bool selectable;
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Builder(
      builder: (context) {
        final String textContent = element.textContent;
        final int sentenceId = int.parse(textContent);
        return MarkdownEmbeddedSentence(
          sentenceId: sentenceId,
          fontSize: fontSize,
        );
      },
    );
  }
}
