import 'package:booqs_mobile/components/drill/feed.dart';
import 'package:booqs_mobile/models/custom_section.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:flutter/material.dart';

class CustomSectionLimitedDrills extends StatelessWidget {
  const CustomSectionLimitedDrills({super.key, required this.customSection});
  final CustomSection? customSection;

  @override
  Widget build(BuildContext context) {
    if (customSection == null) {
      return Container();
    }

    final List<Drill> drills = customSection?.drills ?? [];
    final int drillsCount = drills.length;
    final int amountToDisplay = customSection?.amountToDisplay ?? 0;

    if (drillsCount > amountToDisplay) {
      return Column(
        children: [
          DrillFeed(drills: drills),
          const SizedBox(height: 16),
        ],
      );
    }
    return DrillFeed(drills: drills);
  }
}
