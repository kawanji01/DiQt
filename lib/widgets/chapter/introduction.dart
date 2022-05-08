import 'package:booqs_mobile/models/chapter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChapterIntrodiction extends StatelessWidget {
  const ChapterIntrodiction({Key? key, required this.chapter})
      : super(key: key);
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    if (chapter.introduction == '') return Container();

    final introduction = Text(chapter.introduction,
        style: const TextStyle(fontSize: 16, color: Colors.black87));

    Future<void> _moveToReferencePage(url) async {
      if (await canLaunch(url)) {
        await launch(
          url,
        );
      }
    }

    Widget _reference() {
      final String? url = chapter.referenceUrl;
      final String? title = chapter.referenceTitle;
      if (url == null || title == null) return Container();

      return InkWell(
        onTap: () {
          _moveToReferencePage(url);
        },
        child: Container(
            margin: const EdgeInsets.only(top: 32),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black45)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const Text(
                  '外部参照リンク',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            )),
      );
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [introduction, _reference()],
      ),
    );
  }
}