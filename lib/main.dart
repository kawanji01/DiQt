import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/language.dart';
import 'package:booqs_mobile/utils/purchase_service.dart';
import 'package:booqs_mobile/utils/push_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  // 環境変数の読み込み　ref： https://pub.dev/packages/flutter_dotenv
  await dotenv.load(fileName: ".env");
  // RevenueCatの初期化
  final purchase = PurchaseService();
  purchase.initPlatformState();
  // runApp()を実行する前に Flutter Engine の機能を使いたい場合に呼び出しておくおまじないコード。AdMobの初期化 や 画面の向きの固定 に必要。 ref: https://zenn.dev/sugitlab/books/flutter_poke_app_handson/viewer/step7
  WidgetsFlutterBinding.ensureInitialized();
  // プッシュ通知やfirebaseClashlyticsなど、firebase関連の機能を使うための初期化
  await Firebase.initializeApp();
  // クラッシュレポートの設定
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // 広告（AdMob）の初期化 ref: https://developers.google.cn/admob/flutter/quick-start?hl=ja#ios
  MobileAds.instance.initialize();
  // 画面の向きの固定 ref: https://qiita.com/osamu1203/items/6172df89f5270060a44d
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, //縦固定
  ]);

  runApp(
    // Riverpodをアプリに適用
    ProviderScope(
      // i18n ref: https://pub.dev/packages/fast_i18n#getting-started
      child: TranslationProvider(
        child: const DiQt(),
      ),
    ),
  );
}

// 連続解答報酬モーダルのような、Dialogs や Toasts の表示に親Widgetから渡したcontextを使ってしまうと、
// 親がdisposeされた後にその処理を実行しようとした際（たとえば１０問解いた後の次の問題の読み込み（dispose）と報酬の表示が被ってしまった場合）に
// Unhandled Exception: Looking up a deactivated widget's ancestor is unsafe. At this point the state of the widget's element tree is no longer stable.
// が発生してしまう。
// これを防ぐためには、disposeされないWidgetのcontextを渡す必要がある。
// そのために　navigatorKey　をグローバルに定義する。
// Dialogで利用するdisposeされないWidgetのcontextとして、navigatorKey.currentContext を利用する。
// ref: https://stackoverflow.com/questions/56280736/alertdialog-without-context-in-flutter
final navigatorKey = GlobalKey<NavigatorState>();

class DiQt extends ConsumerStatefulWidget {
  const DiQt({Key? key}) : super(key: key);

  @override
  DiQtState createState() => DiQtState();
}

class DiQtState extends ConsumerState<DiQt> {
  @override
  void initState() {
    super.initState();
    // プッシュ通知をタップしたときの画面遷移の設定
    PushNotificationHandler.setTransitonWhenNotificationTapped(context);
    // localeを設定する
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final User? user = ref.read(currentUserProvider);
      await LanguageService.setLocale(user);
    });
  }

  @override
  Widget build(BuildContext context) {
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
      supportedLocales: AppLocaleUtils.supportedLocales,
      locale: TranslationProvider.of(context).flutterLocale,
      routes: routes,
    );
  }
}
