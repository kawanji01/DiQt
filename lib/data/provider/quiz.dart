import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 非同期で取得する
final asyncQuizFamily =
    FutureProvider.autoDispose.family<Quiz?, int>((ref, quizId) async {
  final Map? resMap = await RemoteQuizzes.show(quizId);
  if (resMap == null) return null;
  final Quiz quiz = Quiz.fromJson(resMap['quiz']);
  return quiz;
});
