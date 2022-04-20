import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/drill/unsolved_screen_wrapper.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillUnsolvedPage extends ConsumerWidget {
  const DrillUnsolvedPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(drillUnsolvedPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: RouteObserverなりを使って、画面遷移時にインタラクションを消すようにしたい。 ref: https://417.run/pg/flutter-dart/flutter-route-aware/
    /* Future<bool> _closeSnackBar() async {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.of(context).pop();
      return true;
    } */

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: const DrillUnsolvedScreenWrapper(),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
