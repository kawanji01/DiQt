import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserStudyRecords extends ConsumerWidget {
  const UserStudyRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return Container();

    const textStyle = TextStyle(
        fontSize: 28, color: Colors.orange, fontWeight: FontWeight.bold);

    Widget _answerDays() {
      final int answerDays = user.answerDaysCount;
      if (answerDays == 0) return Container();
      return Text(
        '$answerDays日解答中！！',
        style: textStyle,
      );
    }

    Widget _continuousAnswerDays() {
      final int continuousAnswers = user.continuousAnswerDaysCount;
      if (continuousAnswers == 0) return Container();

      return Text(
        '$continuousAnswers日連続解答中！！',
        style: textStyle,
      );
    }

    Widget _continuousGoalAchievement() {
      final int continuousGoalAchievement = user.continuousGoalAchievementCount;
      if (continuousGoalAchievement == 0) return Container();
      return Text(
        '$continuousGoalAchievement日連続目標達成中！！',
        style: textStyle,
      );
    }

    Widget _continuousCompleteReview() {
      final int continuousCompleteReview = user.continuousCompleteReviewCount;
      if (continuousCompleteReview == 0) return Container();
      return Text(
        '$continuousCompleteReview日連続復習達成中！！',
        style: textStyle,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _continuousAnswerDays(),
        _continuousGoalAchievement(),
        _continuousCompleteReview()
      ],
    );
  }
}
