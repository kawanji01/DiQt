// School
import 'package:booqs_mobile/data/remote/schools.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/school.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
final schoolProvider = StateProvider<School?>((ref) => null);
final schoolUidProvider = Provider<String>(
  (ref) =>
      ref.watch(schoolProvider.select((school) => school?.publicUid ?? 'me')),
);
// schoolUidProviderを元にschoolをセットする。 schoolUidがなくても参加しているschoolを取得してくる。
final asyncSchoolProvider = FutureProvider<School?>((ref) async {
  try {
    final String publicUid = ref.read(schoolUidProvider);
    final Map resMap = await RemoteSchools.show(publicUid);
    if (ErrorHandler.isErrorMap(resMap)) return null;
    School school = School.fromJson(resMap['school']);
    ref.read(schoolProvider.notifier).state = school;
    return school;
  } catch (e) {
    return null;
  }
});

// 非同期でChapterのDrillsを取得する
final asynSchoolChaptersProvider = FutureProvider<List<Chapter>?>((ref) async {
  final String publicUid = ref.read(schoolUidProvider);
  final Map resMap = await RemoteSchools.show(publicUid);
  if (ErrorHandler.isErrorMap(resMap)) return null;
  List<Chapter> chapters = [];
  resMap['chapters'].forEach((e) => chapters.add(Chapter.fromJson(e)));
  return chapters;
});
