import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/user/feed_icon.dart';
import 'package:flutter/material.dart';

class UserRanker extends StatelessWidget {
  const UserRanker(
      {Key? key, required this.user, required this.rank, required this.type})
      : super(key: key);
  final User user;
  final int rank;
  final String type;

  @override
  Widget build(BuildContext context) {
    String name(User user) {
      return '$rank位: ${user.name}';
    }

    String answersCount(User user) {
      switch (type) {
        case 'daily':
          return '解答数： ${user.todaysAnswerHistoriesCount}問';
        case 'weekly':
          return '週間解答数： ${user.wholeWeeksAnswerHistoriesCount}問';
        case 'monthly':
          return '月間解答数： ${user.wholeMonthsAnswerHistoriesCount}問';
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
