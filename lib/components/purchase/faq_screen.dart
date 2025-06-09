import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:booqs_mobile/consts/images.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';

class PurchaseFaqScreen extends StatelessWidget {
  const PurchaseFaqScreen({super.key});

  String get storeName => Platform.isIOS ? 'AppStore' : 'Playストア';
  String get howToCancelImageUrl => Platform.isIOS
      ? '$mainImagesUrl/how_to_cancel_on_ios.png'
      : '$mainImagesUrl/how_to_cancel_on_android.png';

  List<Map<String, String>> get subscriptionFaqs => [
        {
          'question': '月の途中で契約したら損になりますか？',
          'answer': 'プレミアムプランは契約した日から1ヶ月後に更新されるので、いつ契約をしても損することはありません。'
        },
        {
          'question': '解約はいつでもできますか？',
          'answer': 'プレミアムプランの解約は、$storeNameの設定からいつでも行うことができます。'
        },
        {
          'question': 'プレミアムプランの解約は簡単ですか？',
          'answer':
              'はい。簡単です。$storeNameアプリから下記の方法で、いつでも解約が可能です。無料体験期間内であれば無料のまま解約ができます。'
        },
      ];

  Widget buildFaqCard(BuildContext context, String question, String answer) {
    final isHowToCancel = question.contains('解約は簡単ですか');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text('Q',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Color(0xFFFFD600),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text('A',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  answer,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),
            ],
          ),
          if (isHowToCancel) ...[
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                howToCancelImageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveValues.dialogHeight(context),
      margin: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'プレミアムプランのよくあるご質問',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87),
                ),
              ),
              const SizedBox(height: 16),
              for (final faq in subscriptionFaqs)
                buildFaqCard(context, faq['question']!, faq['answer']!),
            ],
          ),
        ),
      ),
    );
  }
}
