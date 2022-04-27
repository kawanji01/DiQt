import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/pages/user/show.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFeedIcon extends ConsumerWidget {
  const UserFeedIcon({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    double grid = SizeConfig.blockSizeHorizontal ?? 0;
    // 画面の20%
    double width = grid * 20;
    double paddingRight = grid * 5;

    // Drillページに遷移
    Future _moveToUserPage(user) async {
      ref.read(userProvider.notifier).state = user;
      ref.read(userUidProvider.notifier).state = user.publicUid;
      UserShowPage.push(context);
    }

    Widget _image() {
      // ref: https://www.codegrepper.com/code-examples/dart/fit+image+in+circle+avatar+flutter
      return ClipRRect(
          child: Image.network('${user.iconImageUrl}'),
          borderRadius: BorderRadius.circular(50.0));
    }

    return InkWell(
      onTap: () => {_moveToUserPage(user)},
      child: Container(
          padding: EdgeInsets.only(right: paddingRight),
          child: _image(),
          width: width),
    );
  }
}
