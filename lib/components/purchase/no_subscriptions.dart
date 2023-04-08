import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:flutter/material.dart';

class PurchaseNoSubscriptions extends StatelessWidget {
  const PurchaseNoSubscriptions(
      {Key? key, required this.heading, required this.text})
      : super(key: key);
  final String heading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        PremiumPlanPage.push(context);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(heading,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
              Text(
                text,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54),
              ),
            ],
          )),
    );
  }
}
