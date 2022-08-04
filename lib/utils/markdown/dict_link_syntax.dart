import 'package:markdown/markdown.dart' as md;

// 一行ずつ parse して DiQtLinkBuilder に値を引き渡す
// 例： 《補語にのみ用いて》《話》『元気な』,健康な([[well]])::dictionary_id=1
class DictLinkSyntax extends md.InlineSyntax {
  DictLinkSyntax() : super(r'(.*\[{2}.*?\]{2}.*)');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final keyword = '${match[1]}';
    final md.Element anchor = md.Element('a', [
      md.Element('dictLink', [md.Text(keyword)]),
    ]);
    anchor.attributes['href'] = '';
    parser.addNode(anchor);
    return true;
  }
}
