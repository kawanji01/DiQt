import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/drill/introduction.dart';
import 'package:booqs_mobile/components/drill/order_select_form.dart';
import 'package:booqs_mobile/components/drill/quiz_list_view.dart';
import 'package:booqs_mobile/components/drill/status_tabs.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';

class DrillShowPage extends StatelessWidget {
  const DrillShowPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(drillShowPage);
  }

  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(drillShowPage);
  }

  @override
  Widget build(BuildContext context) {
    final body = Column(
      children: const [
        SizedBox(height: 32),
        DrillIntroduction(),
        DrillOrderSelectForm(type: 'all'),
        SizedBox(height: 40),
        DrillStatusTabs(
          selected: 'all',
        ),
        DrillQuizListView(),
        SizedBox(height: 32),
        SizedBox(height: 160),
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
    );
  }
}
