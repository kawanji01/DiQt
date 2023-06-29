import 'package:booqs_mobile/utils/env_handler.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

// firebase remote config
// ref: https://zenn.dev/snova301/books/6df29a230d681f/viewer/fd6deb
class RemoteConfigService {
  // 初期化
  Future<void> initRemoteConfig() async {
    // ref: https://firebase.google.com/docs/remote-config/get-started?platform=flutter&hl=ja
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    const Map<String, dynamic> params = {
      "maintenance": false,
      "maintenance_dev": false,
    };

    /// アプリ内デフォルトパラメータ値の設定
    await remoteConfig.setDefaults(params);

    /// 値をフェッチ
    await remoteConfig.fetchAndActivate();
  }

  // メンテナンスモードか検証する
  bool isMaintenanceMode() {
    final String key = EnvHandler.isProd() ? "maintenance" : "maintenance_dev";
    final bool isMaintenanceMode = FirebaseRemoteConfig.instance.getBool(key);
    return isMaintenanceMode;
  }

  // アプリの最低バージョン
  String minAppVersion() {
    final String key =
        EnvHandler.isProd() ? "min_app_version" : "min_app_version_dev";
    final String minAppVersion = FirebaseRemoteConfig.instance.getString(key);
    return minAppVersion;
  }
}
