import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';

class DictionarySearchByWebButton extends StatelessWidget {
  const DictionarySearchByWebButton({Key? key, required this.keyword})
      : super(key: key);
  final String keyword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          minimumSize: const Size(double.infinity,
              40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
        ),
        onPressed: () {
          WebPageLauncher.searchEntryByGoogle(keyword);
        },
        icon: const Icon(Icons.search, color: Colors.white),
        label: const Text(
          'Webで検索する',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
