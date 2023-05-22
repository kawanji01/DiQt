import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/drill/feed.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDrillsInProgressScreen extends ConsumerStatefulWidget {
  const UserDrillsInProgressScreen({Key? key}) : super(key: key);

  @override
  UserDrillsInProgressScreenState createState() =>
      UserDrillsInProgressScreenState();
}

class UserDrillsInProgressScreenState
    extends ConsumerState<UserDrillsInProgressScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(asyncDrillsInProgress);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget drillFeed() {
      return ref.watch(asyncDrillsInProgress).when(
            data: (data) => DrillFeed(
              drills: data,
            ),
            error: (err, stack) => Text('Error: $err'),
            loading: () => const LoadingSpinner(),
          );
    }

    return Container(
      height: ResponsiveValues.dialogHeight(context),
      margin: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 24),
          const HeadingMediumGreen(label: '続きから', icon: Icons.bookmark_border),
          drillFeed(),
          const SizedBox(height: 48),
        ],
      )),
    );
  }
}
