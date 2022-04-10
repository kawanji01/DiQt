import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:booqs_mobile/widgets/purchase/delete_button.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/button/large_button.dart';
import 'package:flutter/material.dart';

class PremiumMenuPage extends StatefulWidget {
  const PremiumMenuPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, User user) async {
    return Navigator.of(context).pushNamed(
      premiumMenuPage,
      arguments: user,
    );
  }

  @override
  _PremiumMenuPageState createState() => _PremiumMenuPageState();
}

class _PremiumMenuPageState extends State<PremiumMenuPage> {
  @override
  Widget build(BuildContext context) {
    // 引数のユーザーを取得
    User getUser() {
      return ModalRoute.of(context)!.settings.arguments as User;
    }

    final _user = getUser();

    Widget _weaknessAnalysisButton(user) {
      const String btnText = '弱点分析';
      final String redirectPath = 'users/${user.publicUid}/weakness_analysis';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: const LargeButton(btnText: btnText),
      );
    }

    Widget _answerHistoriesButton(user) {
      const String btnText = '解答履歴';
      final String redirectPath = 'users/${user.publicUid}/answer_histories';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: const LargeButton(btnText: btnText),
      );
    }

    Widget _noteListButton(user) {
      const String btnText = 'ノート一覧';
      final String redirectPath = 'users/${user.publicUid}/memos';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: const LargeButton(btnText: btnText),
      );
    }

    Widget _answerSettingButton(user) {
      const String btnText = '解答・復習設定';
      final String redirectPath = 'users/${user.publicUid}/answer_setting';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
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
              _weaknessAnalysisButton(_user),
              const SizedBox(
                height: 32,
              ),
              _answerHistoriesButton(_user),
              const SizedBox(
                height: 32,
              ),
              _answerSettingButton(_user),
              const SizedBox(
                height: 32,
              ),
              _noteListButton(_user),
              const SizedBox(
                height: 64,
              ),
              PurchaseDeleteButton(user: _user),
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
      bottomNavigationBar: const BottomNavbar(selectedIndex: 3),
    );
  }
}
