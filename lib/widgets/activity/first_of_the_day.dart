import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/user/feed_icon.dart';
import 'package:flutter/material.dart';

class ActivityFirstOfTheDay extends StatelessWidget {
  const ActivityFirstOfTheDay({Key? key, required this.activity})
      : super(key: key);
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final User user = activity.user!;

    const TextStyle textBlack = TextStyle(
        color: Colors.black87, fontSize: 16, fontWeight: FontWeight.normal);

    const TextStyle textGreen = TextStyle(
        color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold);

    final Widget answerDaysCount = RichText(
        text: TextSpan(children: [
      TextSpan(text: user.name, style: textGreen),
      const TextSpan(text: 'が', style: textBlack),
      TextSpan(text: '${activity.amount}日', style: textGreen),
      const TextSpan(text: '解答しました！', style: textBlack),
    ]));

    Widget _continuationCount() {
      if (activity.continuationCount! < 2) {
        return Container();
      }
      return RichText(
          text: TextSpan(children: [
        TextSpan(text: '${activity.continuationCount}日連続', style: textGreen),
        const TextSpan(text: 'で解答しました！', style: textBlack),
      ]));
    }

    Widget _allWeekContinuationCount() {
      if (activity.allWeekContinuationCount == null) {
        return Container();
      }
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '${activity.allWeekContinuationCount}週間連続', style: textGreen),
        const TextSpan(text: 'で解答しました！', style: textBlack),
      ]));
    }

    Widget _allMonthContinuationCount() {
      if (activity.allMonthContinuationCount == null) {
        return Container();
      }
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '${activity.allMonthContinuationCount}ヶ月連続',
            style: textGreen),
        const TextSpan(text: 'で解答しました！', style: textBlack),
      ]));
    }

    Widget _allYearContinuationCount() {
      if (activity.allYearContinuationCount == null) {
        return Container();
      }
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '${activity.allYearContinuationCount}年間連続', style: textGreen),
        const TextSpan(text: 'で解答しました！', style: textBlack),
      ]));
    }

    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        children: [
          UserFeedIcon(user: user),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                answerDaysCount,
                _continuationCount(),
                _allWeekContinuationCount(),
                _allMonthContinuationCount(),
                _allYearContinuationCount()
              ],
            ),
          )
        ],
      ),
    );
  }
}
