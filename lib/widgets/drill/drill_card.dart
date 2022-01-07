import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DrillCard extends StatelessWidget {
  const DrillCard({Key? key, required this.drill}) : super(key: key);
  final Drill drill;

  @override
  Widget build(BuildContext context) {
    // 1,000のようなdelimiterを使って解答数を整形する。参考： https://stackoverflow.com/questions/62580280/how-to-format-numbers-as-thousands-separators-in-dart
    final formatter = NumberFormat('#,###,000');
    final answerHistoriesCount = formatter.format(drill.answerHistoriesCount);

    // Drillページに遷移
    Future _moveToDrillPage(drill) async {
      final String id = drill.publicUid;
      // 外部リンクダイアログを表示
      await showDialog(
          context: context,
          builder: (context) {
            return ExternalLinkDialog(redirectPath: 'drills/$id/unsolved');
          });
    }

    // カードデザインの参考： https://material.io/components/cards/flutter
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.green.withAlpha(30),
        onTap: () {
          _moveToDrillPage(drill);
        },
        child: Column(
          children: [
            ListTile(
              //leading: Image(image: NetworkImage('${chapter.iconUrl}')),
              title: Text(drill.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text(
                '$answerHistoriesCount解答',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Image(image: NetworkImage('${drill.imageUrl}')),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0, left: 16, top: 16, bottom: 32),
              child: Text(
                drill.introduction,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            //ButtonBar(
            //  alignment: MainAxisAlignment.start,
            //  children: [
            //    FlatButton(
            //      textColor: const Color(0xFF6200EE),
            //      onPressed: () {
            // Perform some action
            //      },
            //      child: const Text('ACTION 1'),
            //   ),
            //    FlatButton(
            //      textColor: const Color(0xFF6200EE),
            //      onPressed: () {
            // Perform some action
            //      },
            //      child: const Text('ACTION 2'),
            //    ),
            //  ],
            //),
          ],
        ),
      ),
    );
  }
}
