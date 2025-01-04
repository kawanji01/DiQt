import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/components/drill/icon.dart';
import 'package:flutter/material.dart';

class DrillName extends StatelessWidget {
  const DrillName({super.key, required this.drill});
  final Drill drill;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DrillIcon(drill: drill),
        Expanded(
          child: Text(drill.title),
        )
      ],
    );
  }
}
