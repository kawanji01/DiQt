import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/pages/user/show.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      final String imageUrl = '${user.iconImageUrl}';
      // const String notFoundIconName = 'assets/images/not_found_icon.png';
      final image = CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        height: 56,
        width: 56,
      );

      // ref: https://www.codegrepper.com/code-examples/dart/fit+image+in+circle+avatar+flutter
      return CircleAvatar(
        radius: 16.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: image,
        ),
      );
    }

    return InkWell(
      onTap: () => {_moveToUserPage(user)},
      child: Container(
          height: 56,
          padding: EdgeInsets.only(right: paddingRight),
          child: _image(),
          width: width),
    );
  }
}
