import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // 識別IDを取得
  Future<String> getIndentifier() async {
    String deviceIdentifier = "unknown";
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor!;
    }
    return deviceIdentifier;
  }

  // プラットフォーム情報を取得
  String getPlatform() {
    String platform = "unknown";
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    return platform;
  }

  // デバイスのモデル名を取得
  Future<String> getName() async {
    String deviceName = "unknown";
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine;
    }
    return deviceName;
  }

  // 物理端末かどうかを判定（シミュレータ回避用途）
  Future<bool> isPhysicalDevice() async {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.isPhysicalDevice;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.isPhysicalDevice;
    }
    // その他のプラットフォームでは物理端末とみなす
    return true;
  }
}
