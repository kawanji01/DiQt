import 'dart:convert';
import 'package:booqs_mobile/data/provider/current_exp_provider.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'answer_reward.dart';

// 問題解答をリクエストして、報酬があれば表示する。
class AnswerRequest {
  static Future call(BuildContext context, AnswerNotification notification,
      String answerType) async {
    final Quiz quiz = notification.quiz;

    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');
    if (token == null) return;

    final Uri url = Uri.parse(
        '${DiQtURL.root(context)}/api/v1/mobile/quizzes/${quiz.id}/answer?token=$token');
    final Response res = await post(url, body: {
      'token': token,
      'answer': notification.usersAnswer,
      'correct': '${notification.correct}',
      'answer_type': answerType,
    });

    if (res.statusCode != 200) return;
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    final Map resMap = json.decode(res.body);
    final answerCreator = AnswerCreator.fromJson(resMap['answer_creator']);

    // 解答日数報酬
    await AnswerReward.answerDays(context, answerCreator);
    // 連日解答報酬
    await AnswerReward.continuousAnswerDays(context, answerCreator);
    // 連続週解答報酬
    await AnswerReward.continuationAllWeek(context, answerCreator);
    // 連続月解答報酬
    await AnswerReward.continuationAllMonth(context, answerCreator);
    // 復習達成
    await AnswerReward.completeReview(context, answerCreator);
    // 連続復習達成
    await AnswerReward.continuousCompleteReview(context, answerCreator);
    // 目標達成
    await AnswerReward.goalAchievement(context, answerCreator);
    // 連続目標達成
    await AnswerReward.continuousGoalAvhievement(context, answerCreator);
    // 経験値を更新する
    Provider((ref) {
      ref.read(currentExpProvider.notifier).state =
          resMap['user']['amount_of_exp'];
    });
  }
}
