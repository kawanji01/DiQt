import 'package:flutter/material.dart';

class WordTagButtons extends StatelessWidget {
  const WordTagButtons({Key? key, required this.tags}) : super(key: key);
  final String? tags;

  @override
  Widget build(BuildContext context) {
    if (tags == null) return Container();

    List tagsList = tags!.split(',');

    // タグボタン
    Widget _tagButton(tagName) {
      String? tagText;
      //String? redirectPath;
      String? chapterUid;

      switch (tagName) {
        case 'ngsl':
          tagText = '基礎英単語';
          chapterUid = 'c63ab6e5';
          // redirectPath = 'chapters/c63ab6e5';
          break;
        case 'nawl':
          tagText = '学術頻出';
          chapterUid = '5cedf1da';
          // redirectPath = 'chapters/5cedf1da';
          break;
        case 'tsl':
          tagText = 'TOEIC頻出';
          chapterUid = '26c399f0';
          // redirectPath = 'chapters/26c399f0';
          break;
        case 'bsl':
          tagText = 'ビジネス頻出';
          chapterUid = '4d46ce7f';
          // redirectPath = 'chapters/4d46ce7f';
          break;
        case 'phrase':
          tagText = '頻出英熟語';
          chapterUid = 'c112b566';
          // redirectPath = 'chapters/c112b566';
          break;
        case 'phave':
          tagText = '頻出句動詞';
          chapterUid = '3623e0d5';
          // redirectPath = 'chapters/3623e0d5';
          break;
        default:
          // 該当するタグがなければリターン
          return Container();
      }

      // タグの問題集ページへ遷移
      Future _moveToTagPage() async {
        //await ChapterShowPage.push(context, chapterUid!);

        // 外部リンクダイアログを表示
        //await showDialog(
        //    context: context,
        //    builder: (context) {
        // ./locale/ を取り除いたpathを指定する
        //      return ExternalLinkDialog(redirectPath: redirectPath);
        //    });
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
                  color: Colors.black87,
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
