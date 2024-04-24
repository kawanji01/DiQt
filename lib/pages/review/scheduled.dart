import 'package:booqs_mobile/components/review/answer_setting_button.dart';
import 'package:booqs_mobile/components/review/heading.dart';
import 'package:booqs_mobile/components/shared/premium_recommendation.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/review.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/review/order_select_form.dart';
import 'package:booqs_mobile/components/review/scheduled_quiz_list_view.dart';
import 'package:booqs_mobile/components/review/status_tabs.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/layouts/drawer_menu.dart';
import 'package:booqs_mobile/components/shared/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewScheduledPage extends ConsumerWidget {
  const ReviewScheduledPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(reviewScheduledPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget quizzes() {
      if (ref.watch(premiumEnabledProvider) == false) {
        return Container(
          margin: const EdgeInsets.only(top: 64),
          child: SharedPremiumRecommendation(
              description: t.shared.premium_recommendation),
        );
      }
      return ReviewScheduledQuizListView(
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
              const ReviewOrderSelectForm(type: 'scheduled'),
              const SizedBox(height: 24),
              const ReviewAnswerSettingButton(),
              const SizedBox(height: 48),
              const ReviewStatusTabs(
                selected: 'scheduled',
              ),
              const SizedBox(height: 8),
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
