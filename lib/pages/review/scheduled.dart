import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/review/introduction.dart';
import 'package:booqs_mobile/widgets/review/order_select_form.dart';
import 'package:booqs_mobile/widgets/review/scheduled_quiz_list_view.dart';
import 'package:booqs_mobile/widgets/review/status_tabs.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/drawer_menu.dart';
import 'package:booqs_mobile/widgets/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewScheduledPage extends ConsumerStatefulWidget {
  const ReviewScheduledPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(reviewScheduledPage);
  }

  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(reviewScheduledPage);
  }

  @override
  _ReviewScheduledPageState createState() => _ReviewScheduledPageState();
}

class _ReviewScheduledPageState extends ConsumerState<ReviewScheduledPage> {
  @override
  Widget build(BuildContext context) {
    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            ReviewIntroduction(),
            ReviewOrderSelectForm(type: 'scheduled'),
            SizedBox(height: 40),
            ReviewStatusTabs(
              selected: 'scheduled',
            ),
            SizedBox(height: 8),
            ReviewScheduledQuizListView(),
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
