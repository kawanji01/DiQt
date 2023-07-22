import 'package:booqs_mobile/components/drill_lap/item_list_view.dart';
import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserResumingDrillLapsScreen extends ConsumerStatefulWidget {
  const UserResumingDrillLapsScreen({Key? key}) : super(key: key);

  @override
  UserResumingDrillLapsScreenState createState() =>
      UserResumingDrillLapsScreenState();
}

class UserResumingDrillLapsScreenState
    extends ConsumerState<UserResumingDrillLapsScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveValues.dialogHeight(context),
      margin: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 24),
          HeadingMediumGreen(
              label: t.drillLaps.resume, icon: Icons.bookmark_border),
          const DrillLapItemListView(
            type: 'all',
          ),
          const SizedBox(height: 48),
        ],
      )),
    );
  }
}
