import 'package:booqs_mobile/components/user/icon.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';

class WordRequestItemHeading extends StatelessWidget {
  const WordRequestItemHeading({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final User? user = wordRequest.user;
    final String name = user?.name ?? t.users.anonymous_user;

    return Container(
      /* decoration: BoxDecoration(
        color: const Color(
          0xFFDDFFDD,
        ),
        border: Border.all(
          color: const Color(0xFF88CC88),
          width: 1.0, // Border width
        ),
      ), */
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(children: [
              UserIcon(
                user: user,
                widthPercent: 6,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          ),
          Text(
            t.wordRequests.edited_at(
                time: DateTimeFormatter.createTimeAgoString(
                    wordRequest.createdAt)),
            style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
