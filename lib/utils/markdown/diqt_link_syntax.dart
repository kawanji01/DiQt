import 'package:markdown/markdown.dart' as md;

class DiQtLinkSyntax extends md.InlineSyntax {
  DiQtLinkSyntax() : super(r'\[\[(.+?)\]\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    parser.addNode(md.Element.text('DiQtLink', match[1]!));
    return true;
  }
}
