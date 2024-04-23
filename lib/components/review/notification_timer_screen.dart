import 'package:booqs_mobile/components/answer_setting/review_notification.dart';
import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/user/form/time_zone_name.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/review/index.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewNotificationTimerScreen extends ConsumerStatefulWidget {
  const ReviewNotificationTimerScreen({super.key});

  @override
  ConsumerState<ReviewNotificationTimerScreen> createState() =>
      _ReviewNotificationTimerScreenState();
}

class _ReviewNotificationTimerScreenState
    extends ConsumerState<ReviewNotificationTimerScreen> {
  bool _isReqeusting = false;

  Future<void> update() async {
    setState(() => _isReqeusting = true);
    EasyLoading.show();
    final Map resMap = await RemoteUsers.setReviewTimer(
      reviewNotificationTimer: ref.watch(reviewNotificationTimerProvider),
      reviewNotificationEnabled: ref.watch(reviewNotificationEnabledProvider),
      timeZoneName: ref.watch(userTimeZoneNameProvider),
    );
    EasyLoading.dismiss();
    setState(() => _isReqeusting = false);
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorToast(context, resMap);
      return;
    }
    final String message = resMap['message'] ?? t.shared.update_succeeded;
    final SnackBar snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    final User user = User.fromJson(resMap['user']);
    ref.read(currentUserProvider.notifier).update(user);
    final AnswerSetting answerSetting =
        AnswerSetting.fromJson(resMap['answer_setting']);
    ref.read(answerSettingProvider.notifier).state = answerSetting;
    ReviewIndexPage.push(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: ResponsiveValues.dialogHeight(context),
      width: ResponsiveValues.dialogWidth(context),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                HeadingMediumGreen(
                    label: t.answerSettings.set_review_notification),
                const SizedBox(height: 24),
                const AnswerSettingReviewNotification(),
                const SizedBox(height: 24),
                const UserFormTimeZoneName(),
                const SizedBox(height: 40),
                InkWell(
                    onTap: _isReqeusting ? null : () => update(),
                    child: MediumGreenButton(
                      label: t.shared.set_up,
                      fontSize: 18,
                      icon: Icons.update,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
