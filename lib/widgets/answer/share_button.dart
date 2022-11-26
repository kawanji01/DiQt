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

    void _shareText(String text, String subject) async {
      await Share.share(text, subject: subject);
    }

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: const Size(double.infinity,
            40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
      ),
      onPressed: () => {_shareText(sharedText, 'DiQt')},
      icon: const Icon(Icons.share, color: Colors.white),
      label: const Text(
        '記録をシェアする',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
      ),
    );
  }
}
