import 'package:booqs_mobile/utils/app_review_service.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/shared/contact_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerRequestingReviewScreen extends ConsumerStatefulWidget {
  const AnswerRequestingReviewScreen({Key? key}) : super(key: key);

  @override
  AnswerGoalAchievementScreenState createState() =>
      AnswerGoalAchievementScreenState();
}

class AnswerGoalAchievementScreenState
    extends ConsumerState<AnswerRequestingReviewScreen> {
  bool _isNo = false;
  @override
  Widget build(BuildContext context) {
    Widget screen() {
      // 問い合わせフォーム
      if (_isNo) {
        return const ContactFormScreen();
      }
      // 気に入ったかどうかのクローズドクエスション画面
      return Container(
        height: ResponsiveValues.dialogHeight(context),
        width: ResponsiveValues.dialogWidth(context),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Column(children: const [
              SizedBox(height: 40),
              Text('こんなにもご利用いただき、本当にありがとうございます！！🙇‍♂️\nDiQtは気に入っていただけましたでしょうか？',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              SizedBox(height: 32),
            ]),
            // 評価ボタン
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      // 「いいえ」
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 56,
                          margin: const EdgeInsets.only(right: 8),
                          child: TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _isNo = true;
                              });
                            },
                            icon: const Icon(
                              Icons.thumb_down,
                              size: 18,
                              color: Colors.red,
                            ),
                            label: const Text('いいえ',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      // 「はい」
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 56,
                          margin: const EdgeInsets.only(left: 8),
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.thumb_up,
                              color: Colors.white,
                            ),
                            label: const Text('はい',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            onPressed: () async {
                              // ユーザーのappFavored（アプリを気に入った）をtrueにする & レビューを求める
                              AppReviewService.favorApp();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      );
    }

    return screen();
  }
}
