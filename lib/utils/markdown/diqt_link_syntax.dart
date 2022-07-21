import 'package:markdown/markdown.dart' as md;

// 一行ずつ parse して DiQtLinkBuilder に値を引き渡す
// 例： 《補語にのみ用いて》《話》『元気な』,健康な([[well]])::dictionary_id=1
class DiQtLinkSyntax extends md.InlineSyntax {
  DiQtLinkSyntax(this.dictionaryId) : super(r'(.*\[{2}.*?\]{2}.*)');
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
