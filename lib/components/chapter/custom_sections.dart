import 'package:booqs_mobile/components/custom_section/item.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/custom_section.dart';
import 'package:flutter/material.dart';

class ChapterCustomSections extends StatelessWidget {
  const ChapterCustomSections(
      {super.key, required this.chapter, required this.customSections});
  final Chapter chapter;
  final List<CustomSection> customSections;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: customSections
          .map((customSection) =>
              CustomSectionItem(customSectionId: customSection.id))
          .toList(),
    );
  }
}
