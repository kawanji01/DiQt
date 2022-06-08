import 'package:booqs_mobile/data/provider/loaded_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/solved_quiz_ids.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/notifications/loading_unsolved_quizzes.dart';
import 'package:booqs_mobile/services/sanitizer.dart';
import 'package:booqs_mobile/utils/answer/answer_interaction.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/text_to_speech.dart';
import 'package:booqs_mobile/widgets/answer/paywall_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 必要なWidgetは外から渡す。そうしないとコンテンツが解かれて消えるまでにコンテンツがリビルドされて、選択肢が一瞬ランダムに表示されるなど不細工なことになる。ref: https://qiita.com/chooyan_eng/items/ec11f6dcf714f7a2fa3d
class QuizUnsolvedContent extends ConsumerStatefulWidget {
  const QuizUnsolvedContent(
      {Key? key,
      required this.quiz,
      required this.header,
      required this.question,
      required this.answer,
      required this.footer})
      : super(key: key);

  final Quiz quiz;
  final Widget header;
  final Widget question;
  final Widget answer;
  final Widget footer;

  @override
  _QuizUnsolvedContentState createState() => _QuizUnsolvedContentState();
}

class _QuizUnsolvedContentState extends ConsumerState<QuizUnsolvedContent> {
  bool _isVisible = true;
  bool _isOpaque = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Quiz quiz = widget.quiz;
    final List<int> loadedQuizIds = ref.watch(loadedQuizIdsProvider);

    // 正解を読み上げる
    void _speakCorrectAnswer(notification) {
      final Quiz quiz = notification.quiz;
      if (quiz.answerReadAloud) {
        final int? langNumber = quiz.langNumberOfAnswer;
        // TTSできちんと読み上げるためにDiQtリンクを取り除いた平文を渡す
        final String speechText = Sanitizer.removeDiQtLink(quiz.correctAnswer);
        TextToSpeech.speak(langNumber, speechText);
      }
    }

    return NotificationListener<AnswerNotification>(
      onNotification: (notification) {
        final int todaysAnswersCount = ref.watch(todaysAnswersCountProvider);
        final bool premiumEnabled = ref.watch(premiumEnabledProvider);
        // 無料ユーザーで１００問以上解いたユーザーにはペイウォールを表示する
        if (todaysAnswersCount > 99 && premiumEnabled == false) {
          Dialogs.slideFromBottomFade(const AnswerPaywallScreen());
          // trueを返すことで通知がこれ以上親に伝わらない。
          return true;
        }
        // 今日の解答数のカウンターを+1する。
        ref.read(todaysAnswersCountProvider.notifier).state =
            todaysAnswersCount + 1;
        // 正解を読み上げる
        _speakCorrectAnswer(notification);
        // 解答インタラクションを表示する
        AnswerInteraction.show(notification, context);

        // 解答した問題が再描画されないように、問題のIDをproviderに追加する。
        ref.read(solvedQuizIdsProvider.notifier).state.add(quiz.id);
        // setStateするとともにプロバイダーも更新してonEndで利用できるようにする
        setState(() {
          _isOpaque = false;
        });
        // falseを返すことで通知がさらに親のWidgetに伝わる。
        return false;
      },
      // FadeOutで問題を隠す & 高さも消失させる ref: https://stackoverflow.com/questions/58493886/animated-opacity-and-hiding-the-widget-so-its-not-clickable
      child: AnimatedOpacity(
        opacity: _isOpaque ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 800),
        onEnd: () {
          if (_isOpaque == false) {
            // 解答した問題が再描画されないように、問題のIDをproviderに追加する。
            final List<int> solvedQuizIds = ref.watch(solvedQuizIdsProvider);
            print('solvedQuizIds');
            print(solvedQuizIds);
            print(solvedQuizIds.length);
            // 読み込まれた問題（loadedQuizIds）のうち、実際に画面に表示されている問題のIDを算出する （読み込まれた問題 - 解いた問題のID （solvedQuizIdsProvider））
            //loadedQuizIds
            //    .removeWhere((int quizId) => solvedQuizIds.contains(quizId));
            //print('displayedQuizIDs');
            //print(loadedQuizIds);
            // 画面に表示されている問題がなければ、次の問題を読み込むために親（reviewやdrillのscreen）に通知する。
            //
            // 10の倍数の解答数でリロードする
            if (solvedQuizIds.length % 10 == 0) {
              LoadingUnsolvedQuizzesNotification(true).dispatch(context);
            }
            setState(() {
              _isVisible = false;
            });
          }
        },
        // 必ずコンテンツは外から渡す。
        // そうしないと、コンテンツが解かれて消えるまでにコンテンツがリビルドされて、選択肢が一瞬ランダムに表示されるなど不細工なことになる。ref: https://qiita.com/chooyan_eng/items/ec11f6dcf714f7a2fa3d
        child: Visibility(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 24),
                widget.header,
                widget.question,
                const SizedBox(height: 16),
                widget.answer,
                const SizedBox(height: 8),
                widget.footer,
                const SizedBox(height: 8),
              ],
            ),
          ),
          visible: _isVisible,
        ),
      ),
    );
  }
}
