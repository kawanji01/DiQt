import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillIcon extends ConsumerWidget {
  const DrillIcon({Key? key, required this.drill}) : super(key: key);
  final Drill drill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? currentUser = ref.watch(currentUserProvider);
    SizeConfig().init(context);
    double grid = SizeConfig.blockSizeHorizontal ?? 0;
    // 画面の12%
    double width = grid * 14;
    double paddingRight = grid * 4;

    return Container(
      padding: EdgeInsets.only(right: paddingRight),
      width: width,
      child: InkWell(
        onTap: () {
          if (currentUser == null) {
            const snackBar = SnackBar(content: Text('問題を解くにはログインが必要です。'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            UserMyPage.push(context);
          } else {
            ref.read(drillProvider.notifier).state = drill;
            DrillUnsolvedPage.push(context);
          }
        },
        child: Image.network(drill.thumbnailUrl),
      ),
    );
  }
}
