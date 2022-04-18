import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/widgets/drill/card.dart';
import 'package:flutter/material.dart';

class DrillFeed extends StatelessWidget {
  const DrillFeed({Key? key, required this.drills}) : super(key: key);
  final List<Drill> drills;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: drills.map((drill) => DrillCard(drill: drill)).toList(),
    );
  }
}
