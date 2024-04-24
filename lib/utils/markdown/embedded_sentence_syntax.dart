import 'package:markdown/markdown.dart' as md;

// 一行ずつ parse して sentence_id を EmbeddedSentenceBuilder に引き渡す
class EmbeddedSentenceSyntax extends md.InlineSyntax {
  EmbeddedSentenceSyntax() : super(r'\{sentence_id=(.*?)\}');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final sentenceId = '${match[1]}';
    final md.Element embeddedSentence =
        md.Element('embeddedSentence', [md.Text(sentenceId)]);
    parser.addNode(embeddedSentence);
    return true;
  }
}
