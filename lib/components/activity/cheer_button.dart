import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/cheers.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/cheer.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/components/button/small_outline_green_button.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityCheerButton extends ConsumerStatefulWidget {
  const ActivityCheerButton({super.key, required this.activity, this.cheer});
  final Activity activity;
  final Cheer? cheer;

  @override
  ActivityCheerButtonState createState() => ActivityCheerButtonState();
}

class ActivityCheerButtonState extends ConsumerState<ActivityCheerButton> {
  bool _tapped = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserProvider);
    final Activity activity = widget.activity;
    final Cheer? cheer = widget.cheer;
    if (user == null) return const LoadingSpinner();
    if (user.id == activity.user?.id) return Container();

    Widget button() {
      // 楽観的UI
      if (cheer != null || _tapped == true) {
        return SmallGreenButton(
          label: t.activities.cheered,
          icon: Icons.favorite,
        );
      }
      return InkWell(
        onTap: () async {
          HapticFeedback.mediumImpact();
          setState(() {
            _tapped = true;
          });
          await RemoteCheers.create(activity.id);
        },
        child: SmallOutlineGreenButton(
          label: t.activities.cheer,
          icon: Icons.favorite,
        ),
      );
    }

    return button();
  }
}
