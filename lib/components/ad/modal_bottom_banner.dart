import 'package:booqs_mobile/components/ad/banner.dart';
import 'package:flutter/material.dart';

class AdModalBottomBanner extends StatelessWidget {
  const AdModalBottomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const AdBanner(),
      const SizedBox(height: 80), // 閉じるボタンの余白
    ]);
  }
}
