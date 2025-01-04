import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserStudyRecords extends ConsumerWidget {
  const UserStudyRecords({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const textStyle = TextStyle(
        fontSize: 28, color: Colors.orange, fontWeight: FontWeight.bold);

    Widget continuousAnswerDays() {
      final int continuousAnswers = user.continuousAnswerDaysCount;
      if (continuousAnswers < 2) return Container();

      return Text(
        t.users.continuous_answer_days_count(count: continuousAnswers),
        style: textStyle,
      );
    }

    Widget continuousGoalAchievement() {
      final int continuousGoalAchievement = user.continuousGoalAchievementCount;
      if (continuousGoalAchievement < 2) return Container();
      return Text(
        t.users.continuous_goal_achievement_count(
            count: continuousGoalAchievement),
        style: textStyle,
      );
    }

    Widget continuousReviewCompletion() {
      final int continuousReviewCompletion =
          user.continuousReviewCompletionCount;
      if (continuousReviewCompletion < 2) return Container();
      return Text(
        t.users.continuous_review_completion_count(
            count: continuousReviewCompletion),
        style: textStyle,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        continuousAnswerDays(),
        continuousGoalAchievement(),
        continuousReviewCompletion()
      ],
    );
  }
}
