import 'package:booqs_mobile/components/home/walkthrough_1.dart';
import 'package:booqs_mobile/components/home/walkthrough_2.dart';
import 'package:booqs_mobile/components/home/walkthrough_3.dart';
import 'package:booqs_mobile/components/home/walkthrough_4.dart';

import 'package:flutter/material.dart';

class HomeIntroduction extends StatelessWidget {
  const HomeIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const [
        HomeWalkthrough1(),
        HomeWalkthrough2(),
        HomeWalkthrough3(),
        HomeWalkthrough4()
      ],
    );
  }
}
