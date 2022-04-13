import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quizProvider = StateProvider<Quiz?>((ref) => null);

// 非同期で取得する Quiz
final asyncQuizProvider = FutureProvider<Quiz?>((ref) async {
  final Quiz? quiz = ref.read(quizProvider);
  final Map? resMap = await RemoteQuizzes.show(quiz!.id);
  if (resMap == null) return null;
  return Quiz.fromJson(resMap['quiz']);
});
