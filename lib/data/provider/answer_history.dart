import 'package:booqs_mobile/models/answer_history.dart';
import 'package:riverpod/riverpod.dart';

final incorrectAnswerHistoriesProvider =
    FutureProvider<List<AnswerHistory>>((ref) async {
  final List<AnswerHistory> list = [];

  return list;
});
