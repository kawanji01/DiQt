import 'package:booqs_mobile/consts/images.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/show.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({super.key, required this.user, this.widthPercent});
  final User? user;
  final int? widthPercent;

  @override
  Widget build(BuildContext context) {
    final int pecent = widthPercent == null ? 20 : widthPercent!;

    SizeConfig().init(context);
    double grid = SizeConfig.blockSizeHorizontal ?? 0;
    double width = grid * pecent;
    // double paddingRight = grid * 5;

    Widget image() {
      final String imageUrl =
          user != null ? user?.iconImageUrl ?? notFoundIcon : notFoundIcon;
      // ref: https://www.codegrepper.com/code-examples/dart/fit+image+in+circle+avatar+flutter
      return CircleAvatar(
        radius: 72.0,
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/not_found_icon.png'),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return InkWell(
      onTap: user == null
          ? null
          : () {
              UserShowPage.push(context, user!.publicUid);
            },
      child: SizedBox(height: width, width: width, child: image()),
    );
  }
}
