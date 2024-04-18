import 'package:booqs_mobile/components/chapter/custom_sections.dart';
import 'package:booqs_mobile/components/chapter/drills.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/custom_section.dart';
import 'package:flutter/widgets.dart';

class ChapterShow extends StatelessWidget {
  const ChapterShow({super.key, required this.chapter});
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    final List<CustomSection> customSections = chapter.customSections ?? [];
    if (customSections.isEmpty) {
      return const ChapterDrills();
    }
    return ChapterCustomSections(
        chapter: chapter, customSections: customSections);
  }
}
