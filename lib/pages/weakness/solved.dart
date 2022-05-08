import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/empty_app_bar.dart';
import 'package:booqs_mobile/widgets/weakness/introduction.dart';
import 'package:booqs_mobile/widgets/weakness/order_select_form.dart';
import 'package:booqs_mobile/widgets/weakness/solved_quiz_list_view.dart';
import 'package:booqs_mobile/widgets/weakness/status_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessSolvedPage extends ConsumerStatefulWidget {
  const WeaknessSolvedPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(weaknessSolvedPage);
  }

  // 戻らせない画面遷移
  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(weaknessSolvedPage);
  }

  @override
  _WeaknessSolvedPageState createState() => _WeaknessSolvedPageState();
}

class _WeaknessSolvedPageState extends ConsumerState<WeaknessSolvedPage> {
  @override
  Widget build(BuildContext context) {
    final _body = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 32),
            WeaknessIntroduction(),
            WeaknessOrderSelectForm(
              type: 'solved',
            ),
            SizedBox(height: 32),
            WeaknessStatusTabs(
              selected: 'solved',
            ),
            SizedBox(height: 8),
            WeaknessSolvedQuizListView(),
            SizedBox(height: 240),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: const EmptyAppBar(),
      body: _body,
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
