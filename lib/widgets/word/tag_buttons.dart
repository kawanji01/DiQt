import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';

class TagButtons extends StatelessWidget {
  const TagButtons({Key? key, required this.tagsList}) : super(key: key);
  final List tagsList;

  @override
  Widget build(BuildContext context) {
    // タグボタン
    Widget _tagButton(tagName) {
      String? tagText;
      String? redirectPath;

      switch (tagName) {
        case 'ngsl':
          tagText = '基礎英単語';
          redirectPath = 'chapters/c63ab6e5';
          break;
        case 'nawl':
          tagText = '学術頻出';
          redirectPath = 'chapters/5cedf1da';
          break;
        case 'tsl':
          tagText = 'TOEIC頻出';
          redirectPath = 'chapters/26c399f0';
          break;
        case 'bsl':
          tagText = 'ビジネス頻出';
          redirectPath = 'chapters/4d46ce7f';
          break;
        default:
          // 該当するタグがなければリターン
          return Container();
      }

      // タグの問題集ページへ遷移
      Future _moveToTagPage() async {
        // 外部リンクダイアログを表示
        await showDialog(
            context: context,
            builder: (context) {
              // ./locale/ を取り除いたpathを指定する
              return ExternalLinkDialog(redirectPath: redirectPath);
            });
      }

      return InkWell(
        onTap: () {
          _moveToTagPage();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          margin: const EdgeInsets.only(left: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            border: Border.all(color: Colors.black54, width: 1),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500),
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.tag,
                    size: 12,
                    color: Colors.black54,
                  ),
                ),
                TextSpan(
                  text: " $tagText",
                ),
              ],
            ),
          ),
        ),
      );
    }

    // タグのボタン（複数）を作成する
    List<Widget> _createTags() {
      List<Widget> tagWidgets = <Widget>[];

      for (String tag in tagsList) {
        Widget tagButton = _tagButton(tag);
        tagWidgets.add(tagButton);
      }
      return tagWidgets;
    }

    // タグを右揃えに並べて返す。
    return Row(
        mainAxisAlignment: MainAxisAlignment.end, children: _createTags());
  }
}
