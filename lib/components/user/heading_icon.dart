import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';

class UserHeadingIcon extends StatelessWidget {
  const UserHeadingIcon({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Row(
        children: [
          UserFeedIcon(user: user),
          Expanded(
            child: Text(
              user.name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
