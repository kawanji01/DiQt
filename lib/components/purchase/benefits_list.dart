import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class PurchaseBenefitsList extends StatelessWidget {
  const PurchaseBenefitsList({super.key});

  @override
  Widget build(BuildContext context) {
    final benefits = [
      {
        'icon': Icons.check_circle_outline,
        'label': t.purchase.unlimited_answers_description(number: '10'),
      },
      {
        'icon': Icons.translate,
        'label': t.purchase.unlimited_translations_description(number: '3'),
      },
      {
        'icon': Icons.smart_toy,
        'label': t.purchase.unlimited_ai_searches_description(number: '3'),
      },
      {
        'icon': Icons.visibility_off,
        'label': t.purchase.ad_free_description,
      },
      {
        'icon': Icons.bolt,
        'label': t.purchase.weakness_description,
      },
      {
        'icon': Icons.note,
        'label': t.purchase.note_description,
      },
      {
        'icon': Icons.analytics,
        'label': t.purchase.answer_analysis_description,
      },
      {
        'icon': Icons.history,
        'label': t.purchase.answer_history_description,
      },
      {
        'icon': Icons.error_outline,
        'label': t.purchase.questions_you_got_wrong_description,
      },
      {
        'icon': Icons.delete_sweep,
        'label': t.purchase.deletion_of_all_reviews_description,
      },
    ];

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 28),
                const SizedBox(width: 8),
                Text(
                  t.purchase.premium_plan_benefits,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...benefits.map((benefit) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(benefit['icon'] as IconData,
                          color: Colors.green, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          benefit['label'] as String,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
