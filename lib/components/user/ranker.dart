import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class UserRanker extends StatelessWidget {
  const UserRanker(
      {super.key, required this.user, required this.rank, required this.type});
  final User user;
  final int rank;
  final String type;

  @override
  Widget build(BuildContext context) {
    String name(User user) {
      return t.ranking.user_ranking(rank: rank, name: user.name);
    }

    String answersCount(User user) {
      switch (type) {
        case 'daily':
          return t.ranking.daily_answer_count(count: user.todaysAnswerHistoriesCount);
        case 'weekly':
          return t.ranking.weekly_answer_count(count: user.wholeWeekAnswerHistoriesCount);
        case 'monthly':
          return t.ranking.monthly_answer_count(count: user.wholeMonthAnswerHistoriesCount);
        default:
          return '';
      }
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
                Text(
                  name(user),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  answersCount(user),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
