import 'package:booqs_mobile/components/shared/cache_network_image.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:flutter/material.dart';

class DrillThumbnail extends StatelessWidget {
  const DrillThumbnail(
      {super.key, required this.drill, required this.drillLap});
  final Drill drill;
  final DrillLap? drillLap;

  @override
  Widget build(BuildContext context) {
    //if (drillLap == null || drillLap?.clearsCount == 0) {
    return SharedCacheNetworkImage(
      url: drill.thumbnailUrl,
    );
    //}
    //return SharedCacheNetworkImage(
    //  url: drill.clearImageUrl,
    //);
  }
}
