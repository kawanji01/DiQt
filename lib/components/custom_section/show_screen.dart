import 'package:booqs_mobile/components/custom_section/drill_list_view.dart';
import 'package:booqs_mobile/components/custom_section/heading.dart';
import 'package:booqs_mobile/models/custom_section.dart';
import 'package:flutter/material.dart';

class CustomSectionShowScreen extends StatelessWidget {
  const CustomSectionShowScreen({super.key, required this.customSection});
  final CustomSection customSection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        CustomSectionHeading(customSection: customSection),
        const SizedBox(height: 16),
        CustomSectionDrillListView(customSectionId: customSection.id),
        const SizedBox(height: 48),
      ],
    );
  }
}
