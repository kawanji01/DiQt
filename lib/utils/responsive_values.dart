import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveValues {
  // サイズ設定
  // desktop: 1080
  // tablet: 550
  // watch: 200

  // EdgeInsets.symmetric(horizontal: xxx) の xxx
  static double horizontalMargin(BuildContext context) {
    SizeConfig().init(context);
    double grid = SizeConfig.blockSizeHorizontal ?? 0;

    return getValueForScreenType(
        context: context, mobile: 20, tablet: grid * 10, desktop: grid * 15);
  }

  // ダイアログの幅
  static double dialogWidth(BuildContext context) {
    SizeConfig().init(context);
    double grid = SizeConfig.blockSizeHorizontal ?? 0;

    return getValueForScreenType(
        context: context,
        mobile: double.infinity,
        tablet: grid * 80,
        desktop: grid * 70);
  }
}
