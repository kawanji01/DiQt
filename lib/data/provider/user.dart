// ユーザーページなどで表示する他のuser
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<User?>((ref) => null);

// IDをもとに非同期でユーザーを取得する
final asyncUserProvider =
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
    FutureProvider.family<List<Chapter>, String>((ref, userUid) async {
  final List<Chapter> schools = [];
  final Map? resMap = await RemoteUsers.schools(userUid);
  if (resMap == null) return schools;

  resMap['schools'].forEach((e) => schools.add(Chapter.fromJson(e)));
  return schools;
});
