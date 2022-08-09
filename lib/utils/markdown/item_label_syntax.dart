import 'package:markdown/markdown.dart' as md;

// 一行ずつ parse して ItemLabelBuilder に値を引き渡す
// ここではitemLabelの記法が使われているかどうかのみ検証する。（アプリはhtmlとは異なりinlineで並べるには特殊な処理が必要なため）
class ItemLabelSyntax extends md.InlineSyntax {
  ItemLabelSyntax() : super(r'(\{\[.*?\]\})');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final keyword = '${match[1]}';
    final md.Element itemLabel = md.Element('itemLabel', [md.Text(keyword)]);
    parser.addNode(itemLabel);
    return true;
  }
}
