import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/answer_history/todays_mistakes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserTodaysMistakesButton extends ConsumerWidget {
  const UserTodaysMistakesButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return Container();
    final int todaysIncorrectAnswersCount = user.todaysAnswerHistoriesCount -
        user.todaysCorrectAnswerHistoriesCount;
    if (todaysIncorrectAnswersCount == 0) return Container();

    return Container(
      margin: const EdgeInsets.only(bottom: 48),
      padding: const EdgeInsets.only(left: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 4),
            blurRadius: 6,
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: const Color(0x30f010f0),
          onTap: () => AnswerHistoryTodaysMistakesPage.push(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.close,
                size: 48,
                color: Colors.red,
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 12),
                    Text(
                      t.answerHistories.todays_mistakes,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      '$todaysIncorrectAnswersCount',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
