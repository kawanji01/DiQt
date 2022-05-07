import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/review/introduction.dart';
import 'package:booqs_mobile/widgets/review/order_select_form.dart';
import 'package:booqs_mobile/widgets/review/quiz_list_view.dart';
import 'package:booqs_mobile/widgets/review/status_tabs.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/drawer_menu.dart';
import 'package:booqs_mobile/widgets/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewAllPage extends ConsumerStatefulWidget {
  const ReviewAllPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(reviewAllPage);
  }

  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(reviewAllPage);
  }

  @override
  _ReviewAllPageState createState() => _ReviewAllPageState();
}

class _ReviewAllPageState extends ConsumerState<ReviewAllPage> {
  @override
  Widget build(BuildContext context) {
    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            ReviewIntroduction(),
            ReviewOrderSelectForm(type: 'all'),
            SizedBox(height: 40),
            ReviewStatusTabs(
              selected: 'all',
            ),
            SizedBox(height: 8),
            ReviewQuizListView(),
            SizedBox(height: 120),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: const EmptyAppBar(),
      body: body,
      bottomNavigationBar: const BottomNavbar(),
      drawer: const DrawerMenu(),
    );
  }
}
