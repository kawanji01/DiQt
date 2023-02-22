import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/review/introduction.dart';
import 'package:booqs_mobile/components/review/order_select_form.dart';
import 'package:booqs_mobile/components/review/scheduled_quiz_list_view.dart';
import 'package:booqs_mobile/components/review/status_tabs.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/drawer_menu.dart';
import 'package:booqs_mobile/components/shared/empty_app_bar.dart';
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
  ReviewScheduledPageState createState() => ReviewScheduledPageState();
}

class ReviewScheduledPageState extends ConsumerState<ReviewScheduledPage> {
  @override
  Widget build(BuildContext context) {
    final body = Column(
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
    );

    return Scaffold(
      appBar: const EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: body,
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
      drawer: const DrawerMenu(),
    );
  }
}
