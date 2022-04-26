import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';

class UserFeedIcon extends StatelessWidget {
  const UserFeedIcon({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double grid = SizeConfig.blockSizeHorizontal ?? 0;
    // 画面の20%
    double width = grid * 20;
    double paddingRight = grid * 5;

    // Drillページに遷移
    Future _moveToUserPage(user) async {
      /* final String? token = await LocalUserInfo.authToken();

      if (token == null) {
        const snackBar = SnackBar(content: Text('問題を解くにはログインが必要です。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      } else {
        ref.read(drillProvider.notifier).state = drill;
        DrillUnsolvedPage.push(context);
      } */
      print('tap');
    }

    Widget _image() {
      // ref: https://www.codegrepper.com/code-examples/dart/fit+image+in+circle+avatar+flutter
      return ClipRRect(
          child: Image.network('${user.iconImageUrl}'),
          borderRadius: BorderRadius.circular(50.0));
    }

    return Container(
        padding: EdgeInsets.only(right: paddingRight),
        child: _image(),
        width: width);
  }
}
