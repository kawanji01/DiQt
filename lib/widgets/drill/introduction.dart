import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/widgets/drill/answer_setting_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillIntroduction extends ConsumerWidget {
  const DrillIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Drill? drill = ref.watch(drillProvider);
    if (drill == null) return Container();

    final title = Text(
      drill.title,
      style: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
    );

    final image = CachedNetworkImage(
      imageUrl: drill.thumbnailUrl,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );

    final introduction = Text(drill.introduction.trimRight(),
        style: const TextStyle(fontSize: 16, color: Colors.black87));

    return Column(
      children: [
        title,
        const SizedBox(height: 8),
        image,
        const SizedBox(height: 16),
        introduction,
        const SizedBox(height: 24),
        const DrillAnswerSettingButton(),
      ],
    );
  }
}
