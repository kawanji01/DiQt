import 'package:booqs_mobile/components/purchase/benefits_screen.dart';
import 'package:booqs_mobile/components/purchase/faq_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:booqs_mobile/utils/purchase_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/components/purchase/introduction_footer.dart';
import 'package:booqs_mobile/components/purchase/restore_button.dart';
import 'package:booqs_mobile/utils/analytics_service.dart';

class PremiumPlanPage extends StatefulWidget {
  const PremiumPlanPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userPremiumPlanPage);
  }

  @override
  State<PremiumPlanPage> createState() => _PremiumPlanScreenState();
}

class _PremiumPlanScreenState extends State<PremiumPlanPage>
    with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  late AnimationController _bounceController;
  late AnimationController _pulseController;
  late Animation<double> _shimmerAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _pulseAnimation;

  int selectedPlan = 1; // 0: 月額, 1: 年額
  late final AnalyticsService _analyticsService;

  @override
  void initState() {
    super.initState();
    _analyticsService = AnalyticsService();
    _logPremiumPlanView();

    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _bounceController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _shimmerAnimation = Tween<double>(begin: -1, end: 1).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    _bounceAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticInOut),
    );

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _bounceController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4CAF50),
              Color(0xFF45a049),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        _buildTrophyIcon(),
                        const SizedBox(height: 16),
                        _buildTitle(),
                        const SizedBox(height: 8),
                        _buildSubtitle(),
                        const SizedBox(height: 24),
                        // _buildTrialBanner(),
                        // const SizedBox(height: 16),
                        _buildDiscountBanner(),
                        const SizedBox(height: 32),
                        const Text(
                          'まずは１週間、無料で試してみましょう！',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        // Text.rich(
                        //   TextSpan(
                        //     children: [
                        //       TextSpan(
                        //           text: '通常は',
                        //           style: TextStyle(
                        //             fontSize: 18,
                        //           )),
                        //       TextSpan(
                        //         text: '¥650/月',
                        //         style: TextStyle(
                        //           color: Colors.red,
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 24,
                        //         ),
                        //       ),
                        //       TextSpan(text: '、'),
                        //       TextSpan(
                        //         text: '¥7,800/年',
                        //         style: TextStyle(
                        //           color: Colors.red,
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 24,
                        //         ),
                        //       ),
                        //       TextSpan(
                        //           text: 'のところ、',
                        //           style: TextStyle(
                        //             fontSize: 18,
                        //           )),
                        //       TextSpan(
                        //           text: '今だけ！',
                        //           style: TextStyle(
                        //             fontSize: 24,
                        //             fontWeight: FontWeight.bold,
                        //           )),
                        //     ],
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                        const SizedBox(height: 32),
                        SizedBox(height: 16),
                        _buildPlanCards(),
                        const SizedBox(height: 32),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton.icon(
                            icon: Icon(Icons.star, color: Colors.green),
                            label: const Text(
                              'プレミアム機能をみる',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                decorationColor: Colors.green,
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                  ),
                                ),
                                builder: (context) =>
                                    const PurchaseBenefitsScreen(),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton.icon(
                            icon: Icon(Icons.help_outline, color: Colors.green),
                            label: const Text(
                              'よくあるご質問を見る',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.green,
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                  ),
                                ),
                                builder: (context) => const PurchaseFaqScreen(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 48),
                        // const Text(
                        //   'まずは１週間、無料で試してみましょう！',
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     color: Colors.black87,
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 24,
                        //   ),
                        // ),
                        const SizedBox(height: 16),
                        // _buildSubscribeButton(),
                        const SizedBox(height: 32),
                        const PurchaseIntroductionFooter(),
                        const PurchaseRestoreButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildSubscribeButton() {
  //   return Container(
  //     width: double.infinity,
  //     height: 60,
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
  //       ),
  //       borderRadius: BorderRadius.circular(30),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Color(0xFF4CAF50).withValues(alpha: 0.4),
  //           blurRadius: 20,
  //           offset: const Offset(0, 10),
  //         ),
  //       ],
  //     ),
  //     child: ElevatedButton(
  //       onPressed: _subscribe,
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: Colors.transparent,
  //         shadowColor: Colors.transparent,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(Icons.rocket_launch, color: Colors.white, size: 24),
  //           const SizedBox(width: 12),
  //           const Text(
  //             '無料トライアルを開始',
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'プレミアムプラン',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildTrophyIcon() {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_bounceAnimation.value),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
              ),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.emoji_events,
              color: Colors.white,
              size: 40,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFF4CAF50), Color(0xFF45a049)],
      ).createShader(bounds),
      child: const Text(
        'プレミアムプラン',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      'DiQtのすべての機能が使い放題になるプランです。',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black87,
        height: 1.4,
      ),
    );
  }

  // Widget _buildTrialBanner() {
  //   return AnimatedBuilder(
  //     animation: _shimmerAnimation,
  //     builder: (context, child) {
  //       return Container(
  //         padding: const EdgeInsets.all(16),
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [
  //               const Color(0xFFE8F5E8),
  //               const Color(0xFFD4EDDA),
  //             ],
  //           ),
  //           borderRadius: BorderRadius.circular(16),
  //           border: Border.all(color: const Color(0xFF4CAF50), width: 2),
  //         ),
  //         child: Stack(
  //           clipBehavior: Clip.none,
  //           children: [
  //             Positioned.fill(
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.circular(14),
  //                 child: Transform.translate(
  //                   offset: Offset(_shimmerAnimation.value * 200, 0),
  //                   child: Container(
  //                     width: 100,
  //                     decoration: BoxDecoration(
  //                       gradient: LinearGradient(
  //                         colors: [
  //                           Colors.transparent,
  //                           Colors.white.withValues(alpha: 0.3),
  //                           Colors.transparent,
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Icon(
  //                   Icons.access_time,
  //                   color: const Color(0xFF2E7D32),
  //                   size: 20,
  //                 ),
  //                 const SizedBox(width: 8),
  //                 const Text(
  //                   '今なら7日間の無料体験期間つき！',
  //                   style: TextStyle(
  //                     color: Color(0xFF2E7D32),
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 16,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildDiscountBanner() {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFFFF3E0),
                const Color(0xFFFFE0B2),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFF9800), width: 2),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Transform.translate(
                    offset: Offset(_shimmerAnimation.value * 200, 0),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white.withValues(alpha: 0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    color: const Color(0xFFE65100),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '期間限定！最大約40%OFF！',
                    style: TextStyle(
                      color: Color(0xFFE65100),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlanCards() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 260,
            child: _buildPlanCard(0, '月額プラン', '¥500', '/ 月', '２３％OFF！',
                originalPrice: '¥650/月'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 260,
            child: _buildPlanCard(1, '年額プラン', '¥4,800', '/ 年', '3000円もお得！',
                originalPrice: '¥7,800/年'),
          ),
        ),
      ],
    );
  }

  Widget _buildPlanCard(
      int index, String title, String price, String period, String? discount,
      {String? originalPrice}) {
    final isSelected = selectedPlan == index;
    final isRecommended = index == 1;

    return GestureDetector(
      onTap: () async {
        HapticFeedback.lightImpact();
        setState(() {
          selectedPlan = index;
        });
        await Future.delayed(const Duration(milliseconds: 100)); // 軽いアニメーション猶予
        _subscribe();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(isRecommended ? 1.05 : 1.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            // color: isSelected ? const Color(0xFFF1F8E9) : Colors.white,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF4CAF50),
              // width: isSelected ? 2 : 1,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? const Color(0xFF4CAF50).withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.05),
                blurRadius: isSelected ? 15 : 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  if (isRecommended) const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (originalPrice != null) ...[
                    Text(
                      originalPrice,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                  ],
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  Text(
                    period,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  if (index == 1) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          //Icon(Icons.star, color: Color(0xFFFF9800), size: 18),
                          SizedBox(width: 4),
                          Text(
                            '¥400/月',
                            style: TextStyle(
                              color: Color(0xFFFF9800),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  if (discount != null)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        discount,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(height: 6),
                ],
              ),
              if (isRecommended)
                Positioned(
                  top: -34,
                  right: -16,
                  child: AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF6B6B)
                                    .withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Text(
                            'おすすめ！',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _logPremiumPlanView() async {
    await _analyticsService.logPremiumPlanView();
  }

  void _subscribe() async {
    final purchase = PurchaseService();
    final planType = selectedPlan == 0 ? 'monthly' : 'annual';
    
    await _analyticsService.logPurchaseAttempt(planType);
    
    EasyLoading.show(status: 'loading...');
    bool subscriptionCompleted = false;
    if (selectedPlan == 0) {
      // 月額
      subscriptionCompleted = await purchase.purchaseMonthlyPlan();
    } else {
      // 年額
      subscriptionCompleted = await purchase.purchaseAnnualPlan();
    }
    print('subscriptionCompleted: $subscriptionCompleted');
    EasyLoading.dismiss();
    if (!mounted) return;
    if (subscriptionCompleted) {
      await _analyticsService.logPurchaseSuccess(planType);
      if (!mounted) return;
      final snackBar = SnackBar(content: Text(t.purchase.purchase_succeded));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      UserMyPage.push(context);
    } else {
      await _analyticsService.logPurchaseFailed(planType);
      if (!mounted) return;
      final snackBar = SnackBar(content: Text('購入に失敗しました。'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
