import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';

class NoteQuizHeader extends StatelessWidget {
  const NoteQuizHeader({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    // 作成日
    final String createdAtTimeAgo =
        DateTimeFormatter.createTimeAgoString(note.createdAt);
    // 更新日
    final String updatedAtTimeAgo =
        DateTimeFormatter.createTimeAgoString(note.updatedAt);

    final timeStamp = Text(
      '更新：$updatedAtTimeAgo / 作成：$createdAtTimeAgo',
      style:
          const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
    );

    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        alignment: Alignment.centerRight,
        child: timeStamp);
  }
}
