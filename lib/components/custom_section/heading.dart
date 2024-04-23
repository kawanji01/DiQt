import 'package:booqs_mobile/components/heading/large_green.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/custom_section.dart';
import 'package:flutter/material.dart';

class CustomSectionHeading extends StatelessWidget {
  const CustomSectionHeading({super.key, required this.customSection});
  final CustomSection? customSection;

  @override
  Widget build(BuildContext context) {
    if (customSection == null) {
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 40),
          child: Text(t.errors.http_status_404));
    }
    return HeadingLargeGreen(
      label: customSection?.title ?? '',
    );
  }
}
