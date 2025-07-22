import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/components/drill/list_item.dart';
import 'package:flutter/material.dart';

class DrillFeed extends StatelessWidget {
  const DrillFeed({super.key, required this.drills});
  final List<Drill>? drills;

  @override
  Widget build(BuildContext context) {
    if (drills == null || drills!.isEmpty) {
      return Container(
          margin: const EdgeInsets.only(top: 32),
          child: Text(
            t.shared.no_items_found(name: t.drills.drills),
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ));
    }
    return Column(
      children: drills!.map((drill) => DrillListItem(drill: drill)).toList(),
    );
  }
}
