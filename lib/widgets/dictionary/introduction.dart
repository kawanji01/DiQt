import 'package:booqs_mobile/models/dictionary.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DictionaryIntroduction extends StatelessWidget {
  const DictionaryIntroduction({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: dictionary.thumbnailUrl!,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );

    final introduction = Text(dictionary.introduction!.trimRight(),
        style: const TextStyle(fontSize: 16, color: Colors.black87));

    return Column(
      children: [
        image,
        const SizedBox(height: 16),
        introduction,
        const SizedBox(height: 24),
      ],
    );
  }
}
