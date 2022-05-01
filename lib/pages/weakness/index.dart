import 'package:booqs_mobile/data/provider/solved_quiz_ids.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/empty_app_bar.dart';
import 'package:booqs_mobile/widgets/weakness/unsolved_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessIndexPage extends ConsumerStatefulWidget {
  const WeaknessIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(weaknessIndexPage);
  }

  @override
  _WeaknessIndexPageState createState() => _WeaknessIndexPageState();
}

class _WeaknessIndexPageState extends ConsumerState<WeaknessIndexPage> {
  @override
  void initState() {
    super.initState();
    // 解答済の問題のIDのリストをリセットする。
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.read(solvedQuizIdsProvider.notifier).state = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: EmptyAppBar(),
      body: WeaknessUnsolvedScreenWrapper(),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
