import 'package:booqs_mobile/components/custom_section/heading.dart';
import 'package:booqs_mobile/components/custom_section/limited_drills.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/custom_sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSectionItem extends ConsumerWidget {
  const CustomSectionItem({super.key, required this.customSectionId});
  final int customSectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future =
        ref.watch(asyncCustomSectionWithLimitedDrillsProvider(customSectionId));

    return future.when(
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
        data: (customSection) {
          return Column(
            children: <Widget>[
              const SizedBox(
                height: 32,
              ),
              CustomSectionHeading(customSection: customSection),
              const SizedBox(
                height: 16,
              ),
              CustomSectionLimitedDrills(customSection: customSection)
            ],
          );
        });
  }
}
