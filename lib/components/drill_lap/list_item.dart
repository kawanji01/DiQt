import 'package:booqs_mobile/components/drill/list_item.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:flutter/material.dart';

class DrillLapListItem extends StatelessWidget {
  const DrillLapListItem({super.key, required this.drillLap});
  final DrillLap drillLap;

  @override
  Widget build(BuildContext context) {
    final Drill? drill = drillLap.drill;
    if (drill == null) {
      return Container();
    }
    return DrillListItem(drill: drill);
  }
}
