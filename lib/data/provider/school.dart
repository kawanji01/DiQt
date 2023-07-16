// School
import 'package:booqs_mobile/data/remote/schools.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/school.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final schoolUidProvider = StateProvider<String>((ref) => '');
//
final schoolProvider = StateProvider<School?>((ref) => null);
// schoolUidProviderを元にschoolをセットする。 schoolUidがなくても参加しているschoolを取得してくる。
final asyncSchoolProvider = FutureProvider<School?>((ref) async {
  try {
    final String uid = ref.read(schoolUidProvider);
    final Map resMap = await RemoteSchools.show(uid);
    if (ErrorHandler.isErrorMap(resMap)) return null;
    School school = School.fromJson(resMap['school']);
    ref.read(schoolUidProvider.notifier).state = school.publicUid;
    ref.read(schoolProvider.notifier).state = school;
    return school;
  } catch (e) {
    return null;
  }
});

// 非同期でChapterのDrillsを取得する
final asynSchoolChaptersProvider = FutureProvider<List<Chapter>?>((ref) async {
  final School? school = ref.read(schoolProvider);
  final Map resMap = await RemoteSchools.show(school!.publicUid);
  if (ErrorHandler.isErrorMap(resMap)) return null;
  List<Chapter> chapters = [];
  resMap['chapters'].forEach((e) => chapters.add(Chapter.fromJson(e)));
  return chapters;
});
