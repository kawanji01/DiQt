import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:booqs_mobile/utils/language_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleState extends StateNotifier<String> {
  // localeは絶対に必要なので、初期値としてデフォルト言語(英語)を指定しておく・
  LocaleState() : super(defaultLangCode);

  // SecureStorageに保存したlocale経由でlocaleを切り替える。
  // localeを更新したい場合は、 await ref.read(currentUserProvider.notifier).logIn(user); を使って、SecureStorageのlocaleを書き換えること。
  Future<String> setLocale() async {
    final String locale = await LocalUserInfo.locale();
    // 全体のlocaleを設定する。
    LocaleSettings.setLocaleRaw(locale);
    // timeagoのlocaleを設定する。
    DateTimeFormatter.setLocale(locale);
    state = locale;
    return locale;
  }

  int get langNumber {
    return LanguageHandler.getLangNumber(state);
  }
}

final localeProvider =
    StateNotifierProvider<LocaleState, String>((ref) => LocaleState());
