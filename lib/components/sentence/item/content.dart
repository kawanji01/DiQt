import 'package:booqs_mobile/components/sentence/item/original.dart';
import 'package:booqs_mobile/components/sentence/item/translation.dart';
import 'package:booqs_mobile/components/shared/audio_button.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/components/sentence/item/tts_button.dart';
import 'package:flutter/material.dart';

class SentenceItemContent extends StatelessWidget {
  const SentenceItemContent({Key? key, required this.sentence})
      : super(key: key);
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    Widget audioButton() {
      if (sentence.originalAudioUrl == null ||
          sentence.originalAudioUrl == '') {
        return SentenceItemTTSButton(
          sentence: sentence,
        );
      } else {
        return AudioButton(url: sentence.originalAudioUrl!);
      }
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              SentenceItemOriginal(sentence: sentence),
              SentenceItemTranslation(
                sentence: sentence,
              ),
            ],
          ),
        ),
        audioButton(),
      ],
    );
  }
}
