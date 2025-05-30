import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class PurchaseFeaturesTable extends StatelessWidget {
  const PurchaseFeaturesTable({super.key});

  Widget checkIcon() =>
      const Icon(Icons.check_circle, color: Color(0xFF43B048), size: 28);
  Widget crossIcon() => const Icon(
        Icons.close_rounded,
        color: Colors.grey,
        size: 28,
      );

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'label': '解答数',
        'free': '30回/日',
        'premium': t.purchase.unlimited,
      },
      {
        'label': '翻訳数',
        'free': '10回/日',
        'premium': t.purchase.unlimited,
      },
      {
        'label': 'AI機能',
        'free': '10回/日',
        'premium': t.purchase.unlimited,
      },
      {
        'label': t.purchase.ad_free,
        'free': crossIcon(),
        'premium': checkIcon(),
      },
      {
        'label': t.purchase.weakness,
        'free': crossIcon(),
        'premium': checkIcon(),
      },
      {
        'label': t.purchase.note,
        'free': crossIcon(),
        'premium': checkIcon(),
      },
      {
        'label': t.purchase.answer_analysis,
        'free': crossIcon(),
        'premium': checkIcon(),
      },
      {
        'label': t.purchase.answer_history,
        'free': crossIcon(),
        'premium': checkIcon(),
      },
      {
        'label': t.purchase.questions_you_got_wrong,
        'free': crossIcon(),
        'premium': checkIcon(),
      },
      {
        'label': t.purchase.deletion_of_all_reviews,
        'free': crossIcon(),
        'premium': checkIcon(),
      },
    ];

    final headerStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 17, color: Colors.grey[800]);
    final cellStyle = const TextStyle(fontSize: 16);
    final premiumStyle = const TextStyle(
        fontSize: 16, color: Color(0xFF43B048), fontWeight: FontWeight.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 18.0, left: 2.0, top: 8.0),
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'プレミアムプランなら\n',
                  style: TextStyle(height: 1.3),
                ),
                TextSpan(
                  text: '全機能を使い放題でお得！',
                  style: TextStyle(height: 1.3),
                ),
              ],
            ),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF43B048),
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: _SpeechBubbleBadge(),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            Container(
              color: Colors.grey[100],
              height: 56,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('機能',
                            style: headerStyle, textAlign: TextAlign.left),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(child: Text('無料', style: headerStyle)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text('プレミアム',
                          style:
                              headerStyle.copyWith(color: Color(0xFF43B048))),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 2,
              color: Colors.grey[300],
            ),
            ...features.asMap().entries.map((entry) {
              final i = entry.key;
              final feature = entry.value;
              final isEven = i % 2 == 0;
              return Container(
                color: isEven ? Colors.white : Colors.grey[50],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 10),
                        child: Text(feature['label'] as String,
                            style: cellStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: feature['free'] is String
                            ? Text(feature['free'] as String, style: cellStyle)
                            : feature['free'] as Widget,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: feature['premium'] is String
                            ? Text(feature['premium'] as String,
                                style: premiumStyle)
                            : feature['premium'] as Widget,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}

class _SpeechBubbleBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          decoration: BoxDecoration(
            color: Color(0xFF43B048),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Text(
            'オススメ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Positioned(
          bottom: -7,
          left: 0,
          right: 0,
          child: Center(
            child: CustomPaint(
              size: const Size(18, 8),
              painter: _TrianglePainter(color: Color(0xFF43B048)),
            ),
          ),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
