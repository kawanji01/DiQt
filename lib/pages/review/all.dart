import 'package:booqs_mobile/components/review/answer_setting_button.dart';
import 'package:booqs_mobile/components/review/heading.dart';
import 'package:booqs_mobile/components/shared/premium_recommendation.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/review.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/review/bulk_deletion_button.dart';
import 'package:booqs_mobile/components/review/order_select_form.dart';
import 'package:booqs_mobile/components/review/quiz_list_view.dart';
import 'package:booqs_mobile/components/review/status_tabs.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/home/drawer_menu.dart';
import 'package:booqs_mobile/components/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewAllPage extends ConsumerWidget {
  const ReviewAllPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(reviewAllPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget quizzes() {
      if (ref.watch(premiumEnabledProvider) == false) {
        return SharedPremiumRecommendation(
            description: t.shared.premium_recommendation);
      }
      return ReviewQuizListView(
        key: UniqueKey(),
        order: ref.watch(reviewOrderProvider),
      );
    }

    return Scaffold(
      appBar: const EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              const ReviewHeading(),
              const ReviewOrderSelectForm(type: 'all'),
              const SizedBox(height: 24),
              const ReviewAnswerSettingButton(),
              const SizedBox(height: 48),
              const ReviewStatusTabs(
                selected: 'all',
              ),
              const SizedBox(height: 40),
              const ReviewBulkDeletionButton(),
              const SizedBox(height: 40),
              quizzes(),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
      drawer: const DrawerMenu(),
    );
  }
}
