import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/drill/unsolved_screen_wrapper.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillUnsolvedPage extends ConsumerWidget {
  const DrillUnsolvedPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(drillUnsolvedPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: const DrillUnsolvedScreenWrapper(),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
