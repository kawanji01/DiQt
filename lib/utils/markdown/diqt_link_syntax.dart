import 'package:markdown/markdown.dart' as md;

class DiQtLinkSyntax extends md.InlineSyntax {
  DiQtLinkSyntax(this.dictionaryId) : super(r'(\[{2}.*?\]{2})');
  final int dictionaryId;

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final keyword = '${match[1]}::dictionary_id=$dictionaryId';
    final md.Element anchor = md.Element('a', [
      md.Element('diqtlink', [md.Text(keyword)]),
    ]);
    anchor.attributes['href'] = '';
    parser.addNode(anchor);
    return true;
  }
}
