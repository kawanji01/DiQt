import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/drill/introduction.dart';
import 'package:booqs_mobile/widgets/drill/order_select_form.dart';
import 'package:booqs_mobile/widgets/drill/solved_quiz_list_view.dart';
import 'package:booqs_mobile/widgets/drill/status_tabs.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';

class DrillSolvedPage extends StatefulWidget {
  const DrillSolvedPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(drillSolvedPage);
  }

  static Future pushReplacement(BuildContext context) async {
    return Navigator.of(context).pushReplacementNamed(drillSolvedPage);
  }

  @override
  State<DrillSolvedPage> createState() => _DrillSolvedPageState();
}

class _DrillSolvedPageState extends State<DrillSolvedPage> {
  @override
  Widget build(BuildContext context) {
    final body = Column(
      children: const [
        SizedBox(height: 32),
        DrillIntroduction(),
        DrillOrderSelectForm(type: 'solved'),
        SizedBox(height: 40),
        DrillStatusTabs(
          selected: 'solved',
        ),
        SizedBox(height: 32),
        DrillSolvedQuizListView(),
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
