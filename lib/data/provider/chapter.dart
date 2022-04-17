import 'package:booqs_mobile/data/remote/chapters.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chapterProvider = StateProvider<Chapter?>((ref) => null);

// 非同期でChapterのDrillsを取得する
final asynChapterDrillsProvider = FutureProvider<List<Drill>?>((ref) async {
  final Chapter? chapter = ref.read(chapterProvider);

  final Map? resMap = await RemoteChapters.show(chapter!.publicUid!);
  if (resMap == null) return null;
  List<Drill> drills = [];
  resMap['data'].forEach((e) => drills.add(Drill.fromJson(e)));

  return drills;
});