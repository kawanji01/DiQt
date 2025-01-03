import 'package:booqs_mobile/models/dictionary.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DictionaryIntroduction extends StatelessWidget {
  const DictionaryIntroduction({super.key, required this.dictionary});
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: dictionary.thumbnailUrl!,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(height: 16),
        Text(dictionary.introduction!.trimRight(),
            style: const TextStyle(fontSize: 16, color: Colors.black87)),
        const SizedBox(height: 24),
      ],
    );
  }
}
