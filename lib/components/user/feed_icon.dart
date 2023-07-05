import 'package:booqs_mobile/consts/images.dart';
import 'package:booqs_mobile/models/user.dart';
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

    Widget image() {
      final String imageUrl = user.iconImageUrl ?? notFoundIcon;
      // const String notFoundIconName = 'assets/images/not_found_icon.png';
      final image = CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            Image.asset('assets/images/not_found_icon.png'),
        fit: BoxFit.cover,
      );

      // ref: https://www.codegrepper.com/code-examples/dart/fit+image+in+circle+avatar+flutter
      return CircleAvatar(
        radius: 72.0,
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: image,
        ),
      );
    }

    return InkWell(
      onTap: () {
        // ref.read(userProvider.notifier).state = user;
        UserShowPage.push(context, user.publicUid);
      },
      child: Container(
        height: 56,
        width: width,
        padding: EdgeInsets.only(right: paddingRight),
        child: image(),
      ),
    );
  }
}
