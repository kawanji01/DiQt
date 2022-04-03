import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter/material.dart';

// 解答時のイベントのエスカレーション ref: https://gist.github.com/KalpeshKundanani/72e9aa09f519fc0f0a60fde44c4f4328
class AnswerNotification extends Notification {
  // ユーザーの答え
  final String usersAnswer;
  // 正解か否か
  final bool correct;
  final Quiz quiz;
  // 問題をフェイドアウトさせるか否か
  final bool fadeOut;
  // 解答リクエストの結果
  final Map? resMap;
  AnswerNotification(
      this.usersAnswer, this.correct, this.quiz, this.fadeOut, this.resMap);
}
