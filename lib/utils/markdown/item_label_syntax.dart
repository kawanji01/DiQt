import 'package:markdown/markdown.dart' as md;

// 一行ずつ parse して ItemLabelBuilder に値を引き渡す
// ここではitemLabelの記法が使われているかどうかのみ検証する。（アプリはhtmlとは異なりinlineで並べるには特殊な処理が必要なため）
class ItemLabelSyntax extends md.InlineSyntax {
  ItemLabelSyntax(this.fontSize) : super(r'(.*\{\[.*?\]\}.*)');
  final double fontSize;

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final keyword = '${match[1]}::fontSize=$fontSize';
    final md.Element anchor = md.Element('a', [
      md.Element('itemLabel', [md.Text(keyword)]),
    ]);
    anchor.attributes['href'] = '';
    parser.addNode(anchor);
    return true;
  }
}
