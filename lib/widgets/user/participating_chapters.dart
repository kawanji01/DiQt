import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/chapter/card_list.dart';
import 'package:flutter/material.dart';

class UserParticipatingChapters extends StatelessWidget {
  const UserParticipatingChapters({Key? key, required this.user})
      : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    final List<Chapter>? chapters = user.participatingChapters;
    if (chapters == null) {
      return Container();
    }
    if (chapters.isEmpty) {
      return Container();
    }

    return Column(
      children: [
        const Text('参加中の教室',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.green,
                height: 4)),
        const SizedBox(height: 24),
        ChapterCardList(chapters: chapters),
      ],
    );
  }
}
