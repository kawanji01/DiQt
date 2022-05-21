import 'package:booqs_mobile/data/provider/answer_analysis.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/answer_analysis/index.dart';
import 'package:booqs_mobile/pages/note/index.dart';
import 'package:booqs_mobile/pages/user/search.dart';
import 'package:booqs_mobile/pages/weakness/unsolved.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/answer_setting/screen.dart';
import 'package:booqs_mobile/widgets/button/large_green_button.dart';
import 'package:booqs_mobile/widgets/purchase/delete_button.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserMenuPage extends ConsumerWidget {
  const UserMenuPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userMenuPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return Container();

    Widget _weaknessAnalysisButton() {
      final String btnText = '苦手な問題（${user.unsolvedWeaknessesCount}）';

      return InkWell(
        onTap: () {
          WeaknessUnsolvedPage.push(context);
        },
        child: LargeGreenButton(
            label: btnText, icon: Icons.check_circle_outline_outlined),
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
        child: const LargeGreenButton(label: btnText, icon: Icons.history),
      );
    }

    Widget _answerAnalysesButton() {
      const String btnText = '解答分析';
      return InkWell(
        onTap: () {
          ref.read(answerAnalysisOrderProvider.notifier).state =
              'correct_answer_rate-asc';
          AnswerAnalysisIndexPage.push(context);
        },
        child: const LargeGreenButton(
            label: btnText, icon: Icons.analytics_outlined),
      );
    }

    Widget _noteListButton() {
      const String btnText = 'ノート一覧';
      return InkWell(
        onTap: () {
          NoteIndexPage.push(context);
        },
        child: const LargeGreenButton(
            label: btnText, icon: Icons.note_alt_outlined),
      );
    }

    Widget _userSearch() {
      const String btnText = 'ユーザーを探す';
      return InkWell(
        onTap: () {
          UserSearchPage.push(context, '');
        },
        child: const LargeGreenButton(label: btnText, icon: Icons.search),
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
        child: const LargeGreenButton(label: btnText, icon: Icons.settings),
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
              _answerAnalysesButton(),
              const SizedBox(
                height: 32,
              ),
              _noteListButton(),
              const SizedBox(
                height: 32,
              ),
              _userSearch(),
              const SizedBox(
                height: 32,
              ),
              _answerSettingButton(),
              const SizedBox(
                height: 64,
              ),
              const PurchaseDeleteButton(),
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
        title: const Text('メニュー'),
      ),
      body: _body(),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
