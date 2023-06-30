import 'dart:async';

import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/crashlytics_service.dart';
import 'package:booqs_mobile/utils/env_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class UniLinksHandler {
  static Future<String?> getInitLink() async {
    if (EnvHandler.isDesktop()) return null;
    try {
      final String? link = await getInitialLink();
      return link;
    } on PlatformException catch (e, str) {
      CrashlyticsService.recordError(e, str);
      return null;
    }
  }

  static StreamSubscription<String?>? linkStreamListen(BuildContext context) {
    if (EnvHandler.isDesktop()) return null;
    return linkStream.listen((String? link) {
      // print('link: $link');
      UniLinksHandler.push(context, link);
    }, onError: (err) {
      CrashlyticsService.recordError(err, null);
    });
  }

  static push(BuildContext context, String? link) {
    if (link == null) return;

    if (link.contains('/reviews')) {
      Navigator.of(context).pushNamed(reviewIndexPage);
    } else {
      Navigator.of(context).pushNamed(indexPage);
    }
  }
}
