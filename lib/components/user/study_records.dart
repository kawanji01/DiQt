import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserStudyRecords extends ConsumerWidget {
  const UserStudyRecords({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const textStyle = TextStyle(
        fontSize: 28, color: Colors.orange, fontWeight: FontWeight.bold);

    Widget continuousAnswerDays() {
      final int continuousAnswers = user.continuousAnswerDaysCount;
      if (continuousAnswers < 2) return Container();

      return Text(
        '$continuousAnswers日連続解答中！！',
        style: textStyle,
      );
    }

    Widget continuousGoalAchievement() {
      final int continuousGoalAchievement = user.continuousGoalAchievementCount;
      if (continuousGoalAchievement < 2) return Container();
      return Text(
        '$continuousGoalAchievement日連続目標達成中！！',
        style: textStyle,
      );
    }

    Widget continuousReviewCompletion() {
      final int continuousReviewCompletion =
          user.continuousReviewCompletionCount;
      if (continuousReviewCompletion < 2) return Container();
      return Text(
        '$continuousReviewCompletion日連続復習達成中！！',
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
