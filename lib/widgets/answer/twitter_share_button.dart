import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AnswerTwitterShareButton extends StatelessWidget {
  const AnswerTwitterShareButton(
      {Key? key, required this.text, required this.url})
      : super(key: key);
  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    // ref: https://yasai.dev/posts/2021-04-08-flutter%E3%81%A7twitter%E3%81%AB%E5%85%B1%E6%9C%89%E3%81%99%E3%82%8B%E3%83%9C%E3%82%BF%E3%83%B3%E3%82%92%E4%BD%9C%E3%81%A3%E3%81%9F/
    void _tweet() async {
      final Map<String, dynamic> tweetQuery = {
        "text": text,
        "url": url,
        "hashtags": 'DiQt'
      };

      final Uri tweetScheme =
          Uri(scheme: "twitter", host: "post", queryParameters: tweetQuery);

      final Uri tweetIntentUrl =
          Uri.https("twitter.com", "/intent/tweet", tweetQuery);

      await canLaunch(tweetScheme.toString())
          ? await launch(tweetScheme.toString())
          : await launch(tweetIntentUrl.toString());
    }

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        minimumSize: const Size(double.infinity,
            40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
      ),
      onPressed: () => {_tweet()},
      icon: const Icon(Icons.share, color: Colors.white),
      label: const Text(
        '記録をTwitterにシェアする',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
