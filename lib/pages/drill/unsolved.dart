import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/drill/answer_setting_action.dart';
import 'package:booqs_mobile/widgets/drill/unsolved_screen.dart';
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
    final Drill? drill = ref.watch(drillProvider);

    Future<bool> _closeSnackBar() async {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.of(context).pop();
      return true;
    }

    return WillPopScope(
      onWillPop: () {
        return _closeSnackBar();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            child: const DrillUnsolvedScreen(),
          ),
        ),
        bottomNavigationBar: const BottomNavbar(),
      ),
    );
  }
}
