import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/drill/feed.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDrillsInProgressScreen extends ConsumerStatefulWidget {
  const UserDrillsInProgressScreen({Key? key}) : super(key: key);

  @override
  _UserDrillsInProgressScreenState createState() =>
      _UserDrillsInProgressScreenState();
}

class _UserDrillsInProgressScreenState
    extends ConsumerState<UserDrillsInProgressScreen> {
  @override
  void initState() {
    ref.refresh(asyncDrillsInProgress);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final future = ref.watch(asyncDrillsInProgress);

    final heading = RichText(
        text: const TextSpan(children: [
      WidgetSpan(
        child: Icon(
          Icons.bookmark_border,
          color: Colors.green,
          size: 28.0,
        ),
      ),
      TextSpan(
          text: ' 続きから',
          style: TextStyle(
              color: Colors.green,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 2))
    ]));

    Widget _drillFeed() {
      return future.when(
        loading: () => const LoadingSpinner(),
        error: (err, stack) => Text('Error: $err'),
        data: (data) => DrillFeed(
          drills: data,
        ),
      );
    }

    return Container(
      height: ResponsiveValues.dialogHeight(context),
      margin: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: SingleChildScrollView(
          child: Column(
        children: [
          heading,
          _drillFeed(),
        ],
      )),
    );
  }
}
