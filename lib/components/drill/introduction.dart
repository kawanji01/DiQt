import 'package:booqs_mobile/data/provider/chapter.dart';
import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/models/chapter.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/pages/chapter/show.dart';
import 'package:booqs_mobile/components/drill/answer_setting_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillIntroduction extends ConsumerWidget {
  const DrillIntroduction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Drill? drill = ref.watch(drillProvider);
    if (drill == null) return Container();

    Widget referenceLink() {
      final Chapter? chapter = drill.chapter;
      if (chapter == null) return Container();

      return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 0),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        onPressed: () {
          ref.read(chapterProvider.notifier).state = chapter;
          ChapterShowPage.push(context);
        },
        child:
            Text(chapter.title, style: const TextStyle(color: Colors.black54)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        referenceLink(),
        // Title
        Text(
          drill.title,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        // Image
        CachedNetworkImage(
            imageUrl: drill.thumbnailUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error)),
        const SizedBox(height: 16),
        // Introduction
        Text(drill.introduction.trimRight(),
            style: const TextStyle(fontSize: 16, color: Colors.black87)),
        const SizedBox(height: 24),
        const DrillAnswerSettingButton(),
      ],
    );
  }
}
