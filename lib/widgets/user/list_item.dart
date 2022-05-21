import 'package:booqs_mobile/models/relationship.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/relationship/follow_button.dart';
import 'package:booqs_mobile/widgets/user/feed_icon.dart';
import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    final Relationship? relationship = user.relationship;
    final information = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.name,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          user.profile ?? '',
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(
          height: 8,
        ),
        RelationshipFollowButton(
          user: user,
          relationship: relationship,
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        children: [
          UserFeedIcon(user: user),
          Expanded(
            child: information,
          ),
        ],
      ),
    );
  }
}
