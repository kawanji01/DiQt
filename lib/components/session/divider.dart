import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SessionDivider extends StatelessWidget {
  const SessionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text(t.sessions.or),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
