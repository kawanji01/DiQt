// ユーザーページなどで表示する他のuser
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/models/school.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<User?>((ref) => null);

// ref: https://riverpod.dev/ja/docs/concepts/modifiers/family
// 【重要】 オブジェクトが一定ではない場合は autoDispose 修飾子との併用が望ましい
// family を使って検索フィールドの入力値をプロバイダに渡す場合、その入力値は頻繁に変わる上に同じ値が再利用されることはありません。
// おまけにプロバイダは参照されなくなっても破棄されないのがデフォルトの動作であるため、この場合はメモリリークにつながります。
final asyncUserFamily =
    FutureProvider.autoDispose.family<User?, String>((ref, userUid) async {
  try {
    final Map? resMap = await RemoteUsers.show(userUid);
    if (resMap == null || resMap['user'] == null) return null;
    User user = User.fromJson(resMap['user']);
    ref.read(userProvider.notifier).state = user;
    return user;
  } catch (e) {
    return null;
  }
});

// 非同期でユーザーの参加中のchapterを取得する
final asyncUserSchoolsProvider =
    FutureProvider.family<List<School>, String>((ref, userUid) async {
  final List<School> schools = [];
  final Map resMap = await RemoteUsers.schools(userUid);
  if (ErrorHandler.isErrorMap(resMap)) return schools;

  resMap['schools'].forEach((e) => schools.add(School.fromJson(e)));
  return schools;
});
