import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/components/drill/icon.dart';
import 'package:flutter/material.dart';

class DrillName extends StatelessWidget {
  const DrillName({Key? key, required this.drill}) : super(key: key);
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
