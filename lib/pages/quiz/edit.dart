import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/quiz/edit_form.dart';
import 'package:booqs_mobile/data/provider/quiz.dart';
import 'package:booqs_mobile/data/provider/shared.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizEditPage extends ConsumerWidget {
  const QuizEditPage({super.key});

  static Future push(BuildContext context, int quizId) async {
    //return Navigator.of(context)
    //    .pushNamed(quizEditPage, arguments: {'quizId': quizId});
    return Navigator.push(
        context,
        MaterialPageRoute(
            // 画面遷移のログを送信するために、settings.nameを設定する。
            settings: RouteSettings(
              name: quizEditPage,
              arguments: {'quizId': quizId},
            ),
            builder: (BuildContext context) {
              return const QuizEditPage();
            },
            fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int quizId = arguments['quizId'];

    return WillPopScope(
      onWillPop: () async {
        final bool result = await Dialogs.confirm(
            context: context,
            title: t.shared.return_confirmation,
            message: t.shared.return_confirmation_description);
        if (result) {
          // 画面遷移を許可するために、編集中を解除する。
          ref.read(sharedEditingContentProvider.notifier).offEdit();
          return true; // trueを返すことで画面遷移を許可
        } else {
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBarDefault(
          title: t.quizzes.edit,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: ResponsiveValues.horizontalMargin(context)),
            child: ref.watch(asyncQuizFamily(quizId)).when(
                data: (quiz) {
                  if (quiz == null) {
                    return Text(t.shared.no_items_found(name: t.quizzes.quiz));
                  }
                  return QuizEditForm(quiz: quiz);
                },
                error: (err, str) => Text('$err'),
                loading: () => const LoadingSpinner()),
          ),
        ),
        bottomNavigationBar: const BottomNavbar(),
      ),
    );
  }
}
