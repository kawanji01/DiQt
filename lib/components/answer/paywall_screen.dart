import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/button/dialog_close_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnswerPaywallScreen extends StatelessWidget {
  const AnswerPaywallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveValues.dialogHeight(context),
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          Column(children: [
            const SizedBox(height: 16),
            // heading
            Text('😵${t.answer.answer_limit_reached}😵',
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            const SizedBox(height: 24),
            // explanation

            Text(
                t.answer.answer_limit_reached_description(
                    number: answersCountLimitForFreeUsers),
                style: const TextStyle(fontSize: 16, color: Colors.black87)),
            const SizedBox(height: 32),

            Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  t.purchase.trial_period_description,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                )),

            const SizedBox(height: 24),

            // premiumButton
            Container(
              padding: const EdgeInsets.only(bottom: 16, right: 8, left: 8),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity,
                        48), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
                  ),
                  onPressed: () {
                    PremiumPlanPage.push(context);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.crown,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: Text(
                    t.purchase.view_premium_plan,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
          ]),
          const DialogCloseButton(),
        ],
      ),
    );
  }
}
