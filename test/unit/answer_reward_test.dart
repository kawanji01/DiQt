import 'package:booqs_mobile/main.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/utils/answer/answer_reward.dart';
import 'package:booqs_mobile/utils/app_review_service.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../builders/answer_history.dart';
import '../builders/user.dart';
import 'answer_reward_test.mocks.dart';

@GenerateMocks([Dialogs, AppReviewService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('utils/answer/answer_reward', () {
    // 周回クリア
    testWidgets('lapClear calls Dialogs.reward when conditions are met',
        (WidgetTester tester) async {
      //// Dialogs.rewardで navigatorKey.currentContext が null になる問題の解決 ////
      // テストランナーはアプリケーションが通常実行されるときとは異なる環境をセットアップし、異なるライフサイクルを持ちます。そのため、テスト環境ではアプリケーションのコンテキストが利用できないことが多くあります。
      // navigatorKey.currentContextがnullになる理由は、このキーが現在アクティブなウィジェットツリーに接続されていないためです。これは、navigatorKeyがアタッチされたウィジェット（この場合はMaterialApp）がテスト環境でまだ作成されていないためです。
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: Container(),
      ));

      final answerCreator = AnswerCreator();
      answerCreator.answerHistory =
          AnswerHistoryBuilder().build(atDrillPage: true);
      answerCreator.drillLap = DrillLap(cleared: true, clearsCount: 0);

      final dialogs = MockDialogs();

      when(dialogs.reward(any)).thenAnswer((_) async => {});

      await AnswerReward.lapClear(answerCreator, dialogs);
      await tester.pump();

      verify(dialogs.reward(any)).called(1);
    });

    // 解答日数報酬
    testWidgets('answerDays calls Dialogs.reward when conditions are met',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: Container(),
      ));

      final answerCreator = AnswerCreator(answerDaysCount: 5);
      answerCreator.answerHistory =
          AnswerHistoryBuilder().build(firstOfTheDay: true);

      final dialogs = MockDialogs();
      when(dialogs.reward(any)).thenAnswer((_) async => {});

      await AnswerReward.answerDays(answerCreator, dialogs);
      await tester.pump();

      verify(dialogs.reward(any)).called(1);
    });

    // 連続解答日数報酬
    testWidgets(
        'continuousAnswerDays calls Dialogs.reward when conditions are met',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: Container(),
      ));

      final answerCreator = AnswerCreator(continuousAnswerDaysCount: 5);
      answerCreator.answerHistory =
          AnswerHistoryBuilder().build(firstOfTheDay: true);

      final dialogs = MockDialogs();

      when(dialogs.reward(any)).thenAnswer((_) async => {});

      await AnswerReward.continuousAnswerDays(answerCreator, dialogs);
      await tester.pump();

      verify(dialogs.reward(any)).called(1);
    });

    // 連週解答報酬
    testWidgets(
        'continuationAllWeek calls Dialogs.reward when conditions are met',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: Container(),
      ));

      final answerCreator = AnswerCreator(continuationAllWeekCount: 1);
      answerCreator.answerHistory = AnswerHistoryBuilder()
          .build(firstOfTheDay: true, continuationAllWeek: true);

      final dialogs = MockDialogs();
      when(dialogs.reward(any)).thenAnswer((_) async => {});

      await AnswerReward.continuationAllWeek(answerCreator, dialogs);
      await tester.pump();

      verify(dialogs.reward(any)).called(1);
    });

    // 連月解答報酬
    testWidgets(
        'continuationAllMonth calls Dialogs.reward when conditions are met',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: Container(),
      ));

      final answerCreator = AnswerCreator(continuationAllMonthCount: 1);
      answerCreator.answerHistory = AnswerHistoryBuilder()
          .build(firstOfTheDay: true, continuationAllMonth: true);

      final dialogs = MockDialogs();

      when(dialogs.reward(any)).thenAnswer((_) async => {});

      await AnswerReward.continuationAllMonth(answerCreator, dialogs);
      await tester.pump();

      verify(dialogs.reward(any)).called(1);
    });

    // 連年解答報酬
    testWidgets(
        'continuationAllYear calls Dialogs.reward when conditions are met',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: Container(),
      ));

      final answerCreator = AnswerCreator(continuationAllYearCount: 1);
      answerCreator.answerHistory = AnswerHistoryBuilder()
          .build(firstOfTheDay: true, continuationAllYear: true);

      final dialogs = MockDialogs();

      when(dialogs.reward(any)).thenAnswer((_) async => {});

      await AnswerReward.continuationAllYear(answerCreator, dialogs);
      await tester.pump();

      verify(dialogs.reward(any)).called(1);
    });

    // 復習達成報酬
    testWidgets('reviewCompletion calls Dialogs.reward when conditions are met',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: Container(),
      ));

      final answerCreator = AnswerCreator();
      answerCreator.answerHistory =
          AnswerHistoryBuilder().build(reviewCompletion: true);

      final dialogs = MockDialogs();

      when(dialogs.reward(any)).thenAnswer((_) async => {});

      await AnswerReward.reviewCompletion(answerCreator, dialogs);
      await tester.pump();

      verify(dialogs.reward(any)).called(1);
    });

    // 連続復習達成報酬
    testWidgets(
        'continuousReviewCompletion calls Dialogs.reward when conditions are met',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: Container(),
      ));

      final answerCreator = AnswerCreator(continuousReviewCompletionCount: 2);
      answerCreator.answerHistory =
          AnswerHistoryBuilder().build(reviewCompletion: true);

      final dialogs = MockDialogs();

      when(dialogs.reward(any)).thenAnswer((_) async => {});

      await AnswerReward.continuousReviewCompletion(answerCreator, dialogs);
      await tester.pump();

      verify(dialogs.reward(any)).called(1);
    });

    // 目標達成報酬
    testWidgets('goalAchievement calls Dialogs.reward when conditions are met',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: Container(),
      ));

      final answerCreator = AnswerCreator();
      answerCreator.answerHistory =
          AnswerHistoryBuilder().build(goalAchievement: true);

      final dialogs = MockDialogs();

      when(dialogs.reward(any)).thenAnswer((_) async => {});

      await AnswerReward.goalAchievement(answerCreator, dialogs);
      await tester.pump();

      verify(dialogs.reward(any)).called(1);
    });

    // 連続目標達成報酬
    testWidgets(
        'continuousGoalAvhievement calls Dialogs.reward when conditions are met',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: Container(),
      ));

      final answerCreator = AnswerCreator(continuousGoalAchievementCount: 2);
      answerCreator.answerHistory =
          AnswerHistoryBuilder().build(goalAchievement: true);

      final dialogs = MockDialogs();

      when(dialogs.reward(any)).thenAnswer((_) async => {});

      await AnswerReward.continuousGoalAvhievement(answerCreator, dialogs);
      await tester.pump();

      verify(dialogs.reward(any)).called(1);
    });

    // 継続者に対して、アプリを気に入ったかどうかを尋ねる。
    testWidgets('requestReview calls dialogs.reward when conditions are met',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: Container(),
      ));

      final answerCreator = AnswerCreator(answerDaysCount: 20);
      answerCreator.user = UserBuilder().build(appFavored: false);
      final dialogs = MockDialogs();
      final appReview = MockAppReviewService();

      when(dialogs.reward(any)).thenAnswer((_) async => {});
      await AnswerReward.requestReview(answerCreator, dialogs, appReview);
      await tester.pump();

      verify(dialogs.reward(any)).called(1);
    });

    // アプリを気に入っている場合は、アプリのレビュー画面を表示する
    testWidgets(
        'requestReview calls AppReviewService.request when conditions are met',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: Container(),
      ));

      final answerCreator = AnswerCreator(answerDaysCount: 40);
      answerCreator.user = UserBuilder().build(appFavored: true);
      final dialogs = MockDialogs();
      final appReview = MockAppReviewService();

      when(appReview.request()).thenAnswer((_) async => {});
      await AnswerReward.requestReview(answerCreator, dialogs, appReview);
      await tester.pump();

      verify(appReview.request()).called(1);
    });
  });
}
