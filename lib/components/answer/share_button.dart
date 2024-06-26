import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class AnswerShareButton extends StatelessWidget {
  const AnswerShareButton({Key? key, required this.text, required this.url})
      : super(key: key);
  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    final String sharedText = '$text #DiQt $url';

    void shareText(String text, String subject) async {
      await Share.share(text, subject: subject);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 120),
      //decoration: BoxDecoration(
      //border: Border.all(color: Colors.black54, width: 2),
      //borderRadius: BorderRadius.circular(24),
      //  ),
      child: IconButton(
        icon: const Icon(Icons.share, color: Colors.black54),
        iconSize: 24,
        onPressed: () => {shareText(sharedText, 'DiQt')},
        padding: EdgeInsets.zero, // サイズを指定するためにパディングをゼロに設定
        constraints: const BoxConstraints(
          minWidth: 48,
          minHeight: 48,
        ),
      ),
    );
  }
}
