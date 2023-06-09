import 'package:booqs_mobile/i18n/translations.g.dart';

class TimeZoneHandler {
  // タイムゾーン名をlocaleで利用できるkeyに変換する
  static String nameToLocaleKey(String name) {
    // Railsの name.parameterize.underscore を Dartで再現する。
    // スペースや特殊文字をアンダースコアに置き換え、全てを小文字に変換
    final transformed = name.replaceAll(RegExp(r'\W+'), '_').toLowerCase();
    // 末尾のアンダースコアを削除
    return transformed.endsWith('_')
        ? transformed.substring(0, transformed.length - 1)
        : transformed;
  }

  // timeZoneNameから多言語化したタイムゾーン名を取得する
  static String nameToI18n(String name) {
    final String key = nameToLocaleKey(name);
    final result = t['timeZone.$key'];
    if (result == null) {
      // print('$key');
      return '';
    }
    return result;
  }
}
