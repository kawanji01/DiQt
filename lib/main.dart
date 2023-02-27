import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  // 環境変数の読み込み　ref： https://pub.dev/packages/flutter_dotenv
  await dotenv.load(fileName: ".env");
  // RevenueCatの初期化
  final purchase = PurchaseService();
  purchase.initPlatformState();
  // runApp()を実行する前に Flutter Engine の機能を使いたい場合に呼び出しておくおまじないコード。AdMobの初期化 や 画面の向きの固定 に必要。 ref: https://zenn.dev/sugitlab/books/flutter_poke_app_handson/viewer/step7
  WidgetsFlutterBinding.ensureInitialized();
  // 広告（AdMob）の初期化 ref: https://developers.google.cn/admob/flutter/quick-start?hl=ja#ios
  MobileAds.instance.initialize();
  // 画面の向きの固定 ref: https://qiita.com/osamu1203/items/6172df89f5270060a44d
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, //縦固定
  ]);
  // ~分前のようなタイムスタンプを表示するための設定。具体的な表示の処理は utils/date_time_formatter にある ref: https://zenn.dev/namioto/articles/0e0034f3b93874
  timeago.setLocaleMessages("ja", timeago.JaMessages());
  //
  LocaleSettings.useDeviceLocale();

  runApp(
    // Riverpodをアプリに適用
    ProviderScope(
      // i18n ref: https://pub.dev/packages/fast_i18n#getting-started
      child: TranslationProvider(
        child: const MyApp(),
      ),
    ),
  );
}

// Dialogs や Toasts の表示に親Widgetから渡したcontextを使ってしまうと、
// 親がdisposeされた後にその処理を実行しようとした際（たとえば１０問解いた後の次の問題の読み込み（dispose）と報酬の表示が被ってしまった場合）に
// Unhandled Exception: Looking up a deactivated widget's ancestor is unsafe. At this point the state of the widget's element tree is no longer stable.
// が発生してしまう。
// これを防ぐためには、disposeされないWidgetのcontextを渡す必要がある。
// そのために　navigatorKey　をグローバルに定義する。
// Dialogで利用するdisposeされないWidgetのcontextとして、navigatorKey.currentContext を利用する。
// ref: https://stackoverflow.com/questions/56280736/alertdialog-without-context-in-flutter
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // locale : https://zenn.dev/dala/books/flutter-basic-app/viewer/create-flashcard-edit
    //String? defaultLocale = Intl.defaultLocale;
    //defaultLocale ??= 'ja';
    //Intl.defaultLocale = defaultLocale;
    //final locale = Locale('ja', '');

    return MaterialApp(
      title: 'DiQt',
      // 上述のUnhandled Exception: Looking up a deactivated widget's ancestor is unsafe.対策
      navigatorKey: navigatorKey,
      // 画面全体に被さるローディングの初期化　ref： https://pub.dev/packages/flutter_easyloading
      builder: EasyLoading.init(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
        textTheme: GoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: LocaleSettings.supportedLocales,
      locale: TranslationProvider.of(context).flutterLocale,
      routes: routes,
    );
  }
}
