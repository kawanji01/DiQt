import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillIcon extends ConsumerWidget {
  const DrillIcon({super.key, required this.drill});
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
            final snackBar = SnackBar(content: Text(t.drills.require_login));
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
