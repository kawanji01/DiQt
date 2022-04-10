import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';

class DrillIcon extends StatelessWidget {
  const DrillIcon({Key? key, required this.drill}) : super(key: key);
  final Drill drill;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double grid = SizeConfig.blockSizeHorizontal ?? 0;
    // 画面の12%
    double width = grid * 14;
    double paddingRight = grid * 4;
    return Container(
        padding: EdgeInsets.only(right: paddingRight),
        child: Image.network(drill.imageUrl),
        width: width);
  }
}
