import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/user/form/lang_settings.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/home/home_page.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserLangInitScreen extends ConsumerStatefulWidget {
  const UserLangInitScreen({super.key});

  @override
  ConsumerState<UserLangInitScreen> createState() => _UserLangInitScreenState();
}

class _UserLangInitScreenState extends ConsumerState<UserLangInitScreen> {
  bool _isReqeusting = false;

  Future<void> update() async {
    setState(() => _isReqeusting = true);
    EasyLoading.show();
    final Map resMap = await RemoteUsers.updateLangs(
      langNumber: ref.watch(userLangNumberProvider),
      learningLangNumber: ref.watch(userLearningLangNumberProvider),
    );
    EasyLoading.dismiss();
    setState(() => _isReqeusting = false);
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorToast(context, resMap);
      return;
    }
    final SnackBar snackBar =
        SnackBar(content: Text(t.shared.update_succeeded));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    final User user = User.fromJson(resMap['user']);
    ref.read(currentUserProvider.notifier).update(user);
    ref.invalidate(asyncMyDictionariesProvider);
    HomePage.push(context);
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
                HeadingMediumGreen(label: t.users.language_settings),
                const SizedBox(height: 24),
                const UserFormLangSettings(),
                const SizedBox(height: 40),
                InkWell(
                    onTap: _isReqeusting ? null : () => update(),
                    child: MediumGreenButton(
                      label: t.shared.update,
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
