import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';

// 解答時のイベントのエスカレーション ref: https://gist.github.com/KalpeshKundanani/72e9aa09f519fc0f0a60fde44c4f4328
class AnswerNotification extends Notification {
  // ユーザーの答え
  final String usersAnswer;
  // 正解か否か
  final bool correct;
  final Quiz quiz;
  // Providerから初期経験値を取得してしまうと、サーバーのレスポンスの速度によっては、
  // AnswerInterationの経験値インジケーターに必要な初期経験値に、解答報酬獲得後の経験値が利用されてしまうので
  // notificationからUserを取得することで防ぐ。
  final User? user;
  // 問題をフェイドアウトさせるか否か
  final bool fadeOut;
  AnswerNotification(
      this.usersAnswer, this.correct, this.quiz, this.user, this.fadeOut);
}
