import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:booqs_mobile/widgets/user/feed_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityDrillLapClear extends ConsumerWidget {
  const ActivityDrillLapClear({Key? key, required this.activity})
      : super(key: key);
  final Activity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User user = activity.user!;
    final Drill drill = activity.drill!;
    final String? drillImageUrl = activity.imageUrl;

    const TextStyle textBlack = TextStyle(
        color: Colors.black87, fontSize: 16, fontWeight: FontWeight.normal);

    const TextStyle textGreen = TextStyle(
        color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold);

    final Widget information = RichText(
      text: TextSpan(
        children: [
          TextSpan(text: user.name, style: textGreen),
          const TextSpan(text: 'が', style: textBlack),
          TextSpan(text: ' ${drill.title}', style: textGreen),
          const TextSpan(text: 'を', style: textBlack),
          TextSpan(text: ' ${activity.amount}周クリア', style: textGreen),
          const TextSpan(text: 'しました！', style: textBlack),
        ],
      ),
    );

    final Widget message = Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        children: [
          UserFeedIcon(user: user),
          Expanded(
            child: information,
          ),
        ],
      ),
    );

    Widget _achievementImage() {
      return InkWell(
        onTap: () {
          ref.read(drillProvider.notifier).state = drill;
          DrillUnsolvedPage.push(context);
        },
        child: CachedNetworkImage(
          imageUrl: drillImageUrl!,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );
    }

    return Column(
      children: [
        message,
        _achievementImage(),
      ],
    );
  }
}
