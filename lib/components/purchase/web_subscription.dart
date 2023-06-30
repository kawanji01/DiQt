import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_browser_dialog.dart';
import 'package:flutter/material.dart';

class PurchaseWebSubscription extends StatelessWidget {
  const PurchaseWebSubscription({Key? key, required this.user})
      : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final String redirectPath = 'users/${user.publicUid}/payment_setting';
        DiQtBrowserDialog.open(context, redirectPath);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Webで契約しています',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
              Text(
                '',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54),
              ),
            ],
          )),
    );
  }
}
