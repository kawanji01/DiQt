import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizDrillTitle extends ConsumerWidget {
  const QuizDrillTitle({Key? key, required this.drill}) : super(key: key);
  final Drill drill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Drillページに遷移
    Future moveToDrillPage(drill) async {
      final String? token = await LocalUserInfo.authToken();

      if (token == null) {
        const snackBar = SnackBar(content: Text('問題を解くにはログインが必要です。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      } else {
        ref.read(drillProvider.notifier).state = drill;
        DrillUnsolvedPage.push(context);
      }
    }

    return Container(
      alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.only(bottom: 4),
      child: TextButton(
        // デフォルトのpadddingを消す ref: https://crieit.net/posts/Flutter-TextButton
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          moveToDrillPage(drill);
        },
        child: Text(
          drill.title,
          style: const TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ),
    );
  }
}
