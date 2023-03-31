import 'package:markdown/markdown.dart' as md;

class CustomTagSyntax extends md.InlineSyntax {
  CustomTagSyntax() : super(r'\[\[(.+?)\]\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    parser.addNode(md.Element.text('customTag', match[1]!));
    return true;
  }
}
