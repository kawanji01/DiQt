import 'package:booqs_mobile/data/remote/chapters.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chapterProvider = StateProvider<Chapter?>((ref) => null);

// 非同期で取得する
final asyncChapterFamily = FutureProvider.autoDispose
    .family<Chapter?, String>((ref, chapterUid) async {
  final Map? resMap = await RemoteChapters.show(chapterUid);
  if (resMap == null) return null;
  final Chapter chapter = Chapter.fromJson(resMap['chapter']);
  ref.read(chapterProvider.notifier).state = chapter;
  return chapter;
});

// 非同期でChapterのDrillsを取得する
final asynChapterDrillsProvider = FutureProvider<List<Drill>?>((ref) async {
  final Chapter? chapter = ref.read(chapterProvider);
  final Map? resMap = await RemoteChapters.show(chapter!.publicUid);
  if (resMap == null) return null;
  List<Drill> drills = [];
  resMap['drills'].forEach((e) => drills.add(Drill.fromJson(e)));

  return drills;
});

// チャプターのリスト
final chaptersProvider = StateProvider<List<Chapter>>((ref) => []);
// 非同期でチャプターのリストを取得する（chaptersProviderも更新する）
final asyncChaptersProvider = FutureProvider<List<Chapter>>((ref) async {
  final List<Chapter> chapters = [];
  final Map? resMap = await RemoteChapters.index();
  if (resMap == null) return chapters;
  resMap['chapters'].forEach((e) => chapters.add(Chapter.fromJson(e)));
  if (resMap['participating_chapters'] != null) {
    resMap['participating_chapters']
        .forEach((e) => chapters.insert(0, Chapter.fromJson(e)));
  }
  ref.read(chaptersProvider.notifier).state = chapters;
  return chapters;
});
