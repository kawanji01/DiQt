import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PurchaseBenefitsScreen extends StatelessWidget {
  const PurchaseBenefitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildFeatureRow(String feature, String free, String premium,
        {bool isHeader = false}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                feature,
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.w600,
                  color: isHeader ? Colors.black87 : Colors.black87,
                  fontSize: isHeader ? 16 : 14,
                ),
              ),
            ),
            Expanded(
              child: Text(
                free,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isHeader
                      ? Colors.grey.shade600
                      : free == '✓'
                          ? const Color(0xFF4CAF50)
                          : free == '✗'
                              ? Colors.red
                              : Colors.grey.shade600,
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  fontSize: isHeader ? 14 : 16,
                ),
              ),
            ),
            Expanded(
              child: Text(
                premium,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isHeader
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFF4CAF50),
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.bold,
                  fontSize: isHeader ? 14 : 16,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget title(String title) {
      return Text(
        title,
        style: const TextStyle(
            fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
      );
    }

    Widget description(String description) {
      return Text(
        description,
        style: const TextStyle(fontSize: 16, color: Colors.black54),
      );
    }

    return Container(
      height: ResponsiveValues.dialogHeight(context),
      margin: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Center(
            child: const Text(
              'プレミアムプランなら',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: const Text(
              '全機能を使い放題でお得！',
              style: TextStyle(
                fontSize: 28,
                color: Color(0xFF4CAF50),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const SizedBox(height: 16),
          buildFeatureRow('機能', '無料', 'プレミアム', isHeader: true),
          const Divider(height: 24),
          buildFeatureRow('解答数', '$answersCountLimitForFreeUsers回/日', '✓'),
          buildFeatureRow('翻訳数', '$translationsCountLimitForFreeUsers回/日', '✓'),
          buildFeatureRow('AI機能', '$aiSearchesCountLimitForFreeUsers回/日', '✓'),
          buildFeatureRow(t.purchase.ad_free, '✗', '✓'),
          buildFeatureRow('問題作成', '✗', '✓'),
          buildFeatureRow(t.purchase.weakness, '✗', '✓'),
          buildFeatureRow(t.purchase.note, '✗', '✓'),
          buildFeatureRow(t.purchase.answer_analysis, '✗', '✓'),
          buildFeatureRow(t.purchase.answer_history, '✗', '✓'),
          buildFeatureRow(t.purchase.questions_you_got_wrong, '✗', '✓'),
          buildFeatureRow(t.purchase.deletion_of_all_reviews, '✗', '✓'),
          buildFeatureRow('優先サポート', '✗', '✓'),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(
                FontAwesomeIcons.crown,
                size: 26,
                color: Colors.green,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                t.purchase.premium_plan_benefits,
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )
            ],
          ),
          const SizedBox(height: 48),
          title(t.purchase.unlimited_answers),
          description(
            t.purchase.unlimited_answers_description(
                number: answersCountLimitForFreeUsers),
          ),
          const SizedBox(height: 48),
          title(t.purchase.unlimited_ai_searches),
          description(
            t.purchase.unlimited_ai_searches_description(
                number: aiSearchesCountLimitForFreeUsers),
          ),
          const SizedBox(height: 48),
          title(t.purchase.unlimited_translations),
          description(
            t.purchase.unlimited_translations_description(
                number: translationsCountLimitForFreeUsers),
          ),
          const SizedBox(height: 48),
          title(t.purchase.ad_free),
          description(
            t.purchase.ad_free_description,
          ),
          const SizedBox(height: 48),
          title(t.purchase.weakness),
          description(
            t.purchase.weakness_description,
          ),
          const SizedBox(height: 48),
          title(t.purchase.note),
          description(
            t.purchase.note_description,
          ),
          const SizedBox(height: 48),
          title(t.purchase.answer_analysis),
          description(
            t.purchase.answer_analysis_description,
          ),
          const SizedBox(height: 48),
          title(t.purchase.answer_history),
          description(
            t.purchase.answer_history_description,
          ),
          const SizedBox(height: 48),
          title(t.purchase.questions_you_got_wrong),
          description(
            t.purchase.questions_you_got_wrong_description,
          ),
          const SizedBox(height: 48),
          title(t.purchase.deletion_of_all_reviews),
          description(
            t.purchase.deletion_of_all_reviews_description,
          ),
          const SizedBox(height: 120),
        ],
      )),
    );
  }
}
