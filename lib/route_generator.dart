import 'package:booqs_mobile/pages/user/show.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final Uri uri = Uri.parse(settings.name!);

    // ユーザー招待機能に用いる動的なルーティング
    if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'users') {
      final String userUid = uri.pathSegments[1];
      return MaterialPageRoute(
        builder: (context) => UserShowPage(),
        settings: RouteSettings(arguments: {'userUid': userUid}),
      );
    }

    //マッチしないルートの場合はnullを返す
    return null;
  }
}