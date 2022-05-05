import 'package:booqs_mobile/data/provider/answer_analysis.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/answer_analysis/index.dart';
import 'package:booqs_mobile/pages/weakness/index.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:booqs_mobile/widgets/answer_setting/screen.dart';
import 'package:booqs_mobile/widgets/purchase/delete_button.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/button/large_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPremiumMenuPage extends ConsumerWidget {
  const UserPremiumMenuPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userPremiumMenuPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return Container();

    Widget _weaknessAnalysisButton() {
      final String btnText = '苦手な問題（${user.unsolvedWeaknessesCount}）';

      return InkWell(
        onTap: () {
          WeaknessIndexPage.push(context);
        },
        child: LargeButton(btnText: btnText),
      );
    }

    Widget _answerHistoriesButton() {
      const String btnText = '解答履歴';
      return InkWell(
        onTap: () {
          ref.read(answerAnalysisOrderProvider.notifier).state =
              'last_answered_at-desc';
          AnswerAnalysisIndexPage.push(context);
        },
        child: const LargeButton(btnText: btnText),
      );
    }

    Widget _noteListButton() {
      const String btnText = 'ノート一覧';
      final String redirectPath = 'users/${user.publicUid}/memos';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: const LargeButton(btnText: btnText),
      );
    }

    Widget _answerSettingButton() {
      const String btnText = '解答・復習設定';
      return InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            // 丸み ref: https://www.codegrepper.com/code-examples/whatever/showmodalbottomsheet+rounded+corners
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
            // showModalBottomSheetで表示される中身
            builder: (context) => const AnswerSettingScreen(
              primary: 'answerSetting',
            ),
          );
        },
        child: const LargeButton(btnText: btnText),
      );
    }

    Widget _body() {
      return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 28),
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 32,
              ),
              _weaknessAnalysisButton(),
              const SizedBox(
                height: 32,
              ),
              _answerHistoriesButton(),
              const SizedBox(
                height: 32,
              ),
              _answerSettingButton(),
              const SizedBox(
                height: 32,
              ),
              _noteListButton(),
              const SizedBox(
                height: 64,
              ),
              PurchaseDeleteButton(user: user),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('プレミアムメニュー'),
      ),
      body: _body(),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
