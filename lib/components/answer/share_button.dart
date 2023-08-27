import 'package:booqs_mobile/i18n/translations.g.dart';
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

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: const Size(double.infinity, 40),
      ),
      onPressed: () => {shareText(sharedText, 'DiQt')},
      icon: const Icon(Icons.share, color: Colors.white),
      label: Text(
        t.shared.share,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
      ),
    );
  }
}
