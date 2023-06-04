import 'package:booqs_mobile/utils/remote_config_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// home画面をテストするためのモックを利用するための設定
final remoteConfigServiceProvider = Provider<RemoteConfigService>((ref) {
  return RemoteConfigService();
});
