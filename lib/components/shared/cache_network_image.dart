import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SharedCacheNetworkImage extends StatelessWidget {
  const SharedCacheNetworkImage({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
