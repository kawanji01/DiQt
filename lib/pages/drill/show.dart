import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/drill/introduction.dart';
import 'package:booqs_mobile/components/drill/order_select_form.dart';
import 'package:booqs_mobile/components/drill/quiz_list_view.dart';
import 'package:booqs_mobile/components/drill/status_tabs.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillShowPage extends ConsumerWidget {
  const DrillShowPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(drillShowPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Column(
            children: [
              const SizedBox(height: 32),
              const DrillIntroduction(),
              const DrillOrderSelectForm(type: 'all'),
              const SizedBox(height: 40),
              const DrillStatusTabs(
                selected: 'all',
              ),
              DrillQuizListView(
                key: UniqueKey(),
                order: ref.watch(drillOrderProvider),
              ),
              const SizedBox(height: 32),
              const SizedBox(height: 160),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
