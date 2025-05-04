import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/user/drill_creator_button.dart';
import 'package:booqs_mobile/components/user/invitation_button.dart';
import 'package:booqs_mobile/data/provider/answer_analysis.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/answer_analysis/index.dart';
import 'package:booqs_mobile/pages/note/index.dart';
import 'package:booqs_mobile/pages/user/contract_details.dart';
import 'package:booqs_mobile/pages/user/drills.dart';
import 'package:booqs_mobile/pages/user/edit.dart';
import 'package:booqs_mobile/pages/user/search.dart';
import 'package:booqs_mobile/pages/weakness/unsolved.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/answer_setting/screen.dart';
import 'package:booqs_mobile/components/button/large_green_button.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/user/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserMenuPage extends ConsumerWidget {
  const UserMenuPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userMenuPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return Container();

    Widget weaknessAnalysisButton() {
      final String btnText =
          '${t.weaknesses.weaknesses}（${user.unsolvedWeaknessesCount}）';

      return InkWell(
        onTap: () {
          WeaknessUnsolvedPage.push(context);
        },
        child: LargeGreenButton(
            label: btnText, icon: Icons.check_circle_outline_outlined),
      );
    }

    Widget answerHistoriesButton() {
      final String btnText = t.answerHistories.answer_histories;
      return InkWell(
        onTap: () {
          ref.read(answerAnalysisOrderProvider.notifier).state =
              'last_answered_at-desc';
          AnswerAnalysisIndexPage.push(context);
        },
        child: LargeGreenButton(label: btnText, icon: Icons.history),
      );
    }

    Widget answerAnalysesButton() {
      final String btnText = t.answerAnalyses.answer_analyses;
      return InkWell(
        onTap: () {
          ref.read(answerAnalysisOrderProvider.notifier).state =
              'correct_answer_rate-asc';
          AnswerAnalysisIndexPage.push(context);
        },
        child: LargeGreenButton(label: btnText, icon: Icons.analytics_outlined),
      );
    }

    Widget drillsButon() {
      final String btnText = t.users.drills;
      return InkWell(
        onTap: () {
          ref.read(userProvider.notifier).state = user;
          UserDrillsPage.push(context);
        },
        child: LargeGreenButton(label: btnText, icon: Icons.question_mark),
      );
    }

    Widget noteListButton() {
      final String btnText = '${t.notes.notes}(${user.notesCount})';
      return InkWell(
        onTap: () {
          NoteIndexPage.push(context);
        },
        child: LargeGreenButton(label: btnText, icon: Icons.note_alt_outlined),
      );
    }

    Widget userSearch() {
      return InkWell(
        onTap: () {
          UserSearchPage.push(context, '');
        },
        child: LargeGreenButton(label: t.users.find_users, icon: Icons.search),
      );
    }

    Widget accountSetting() {
      final String btnText = t.users.edit;
      return InkWell(
          onTap: () {
            UserEditPage.push(context);
          },
          child: LargeGreenButton(
            label: btnText,
            icon: Icons.manage_accounts,
          ));
    }

    Widget contractDetails() {
      return InkWell(
          onTap: () {
            UserContractDetailsPage.push(context);
          },
          child: LargeGreenButton(
            label: t.users.contract_details,
            icon: Icons.manage_accounts,
          ));
    }

    Widget answerSettingButton() {
      final String btnText = t.answerSettings.answer_setting;
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
        child: LargeGreenButton(label: btnText, icon: Icons.settings),
      );
    }

    return Scaffold(
      appBar: AppBarDefault(
        title: t.users.menu,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context),
          ),
          padding: const EdgeInsets.symmetric(vertical: 28),
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 32,
              ),
              weaknessAnalysisButton(),
              const SizedBox(
                height: 32,
              ),
              answerHistoriesButton(),
              const SizedBox(
                height: 32,
              ),
              answerAnalysesButton(),
              const SizedBox(
                height: 32,
              ),
              drillsButon(),
              const SizedBox(
                height: 32,
              ),
              UserDrillCreatorButton(
                user: user,
              ),
              const SizedBox(
                height: 32,
              ),
              noteListButton(),
              const SizedBox(
                height: 32,
              ),
              UserInvitationButton(),
              const SizedBox(
                height: 32,
              ),
              userSearch(),
              const SizedBox(
                height: 32,
              ),
              accountSetting(),
              const SizedBox(
                height: 32,
              ),
              answerSettingButton(),
              const SizedBox(
                height: 32,
              ),
              contractDetails(),
              const SizedBox(
                height: 32,
              ),
              const UserLogoutButton(),
              const SizedBox(
                height: 64,
              ),
              // const PurchaseDeleteButton(),
              // const SizedBox(
              //   height: 80,
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
