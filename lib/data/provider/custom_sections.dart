// 非同期でCustomSectionのDrillsを取得する
import 'package:booqs_mobile/data/remote/custom_sections.dart';
import 'package:booqs_mobile/models/custom_section.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customSectionProvider = StateProvider<CustomSection?>((ref) => null);

// 非同期でamount_to_displayの数だけDrillsを持つCustomSectionを取得する
final asyncCustomSectionWithLimitedDrillsProvider = FutureProvider.autoDispose
    .family<CustomSection?, int>((ref, customSectionId) async {
  final Map resMap = await RemoteCustomSections.limitedDrills(customSectionId);
  if (ErrorHandler.isErrorMap(resMap)) return null;
  final CustomSection customSection =
      CustomSection.fromJson(resMap['custom_section']);
  return customSection;
});
