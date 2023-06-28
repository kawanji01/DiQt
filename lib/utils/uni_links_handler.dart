import 'package:booqs_mobile/routes.dart';
import 'package:flutter/material.dart';

class UniLinksHandler {
  static push(BuildContext context, String? link) {
    if (link == null) return;

    if (link.contains('/reviews')) {
      Navigator.of(context).pushNamed(reviewIndexPage);
    } else {
      Navigator.of(context).pushNamed(indexPage);
    }
  }
}
