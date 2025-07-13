import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/firebase_options.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/route_generator.dart';
import 'package:booqs_mobile/utils/crashlytics_service.dart';
import 'package:booqs_mobile/utils/mobile_ad_service.dart';
import 'package:booqs_mobile/utils/purchase_service.dart';
import 'package:booqs_mobile/utils/remote_config_service.dart';
import 'package:booqs_mobile/utils/sentry_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booqs_mobile/utils/safe_google_fonts.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  // runApp()を実行する前に Flutter Engine の機能を使いたい場合に呼び出しておくおまじないコード。
  // AdMobの初期化 や 画面の向きの固定 に必要。 ref: https://zenn.dev/sugitlab/books/flutter_poke_app_handson/viewer/step7
  WidgetsFlutterBinding.ensureInitialized();
  
  // 環境変数の読み込み　ref： https://pub.dev/packages/flutter_dotenv
  await dotenv.load(fileName: ".env");
  
  // Sentryの初期化
  await SentryService.initialize();
  
  await SentryFlutter.init(
    (options) => SentryService.configure(options),
    appRunner: () async {
      // RevenueCatの初期化
      final purchase = PurchaseService();
      purchase.initPlatformState();
      
      // プッシュ通知やfirebaseClashlyticsなど、firebase関連の機能を使うための初期化
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      
      // クラッシュレポートの設定
      CrashlyticsService.initialize();
      
      // remoteConfigの設定
      await RemoteConfigService().initRemoteConfig();
      
      // 広告（AdMob）の初期化 ref: https://developers.google.cn/admob/flutter/quick-start?hl=ja#ios
      MobileAdsService.initilize();
      
      // 画面の向きの固定 ref: https://qiita.com/osamu1203/items/6172df89f5270060a44d
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp, //縦固定
      ]);

      runApp(
        // Riverpodをアプリに適用
        ProviderScope(
          // i18n(slang)の適応 ref: https://pub.dev/packages/slang#getting-started
          child: TranslationProvider(
            child: const DiQt(),
          ),
        ),
      );
    },
  );
}

///// navigatorKeyの目的： 報酬モーダルの表示 ////
// 連続解答報酬などの表示で利用する、utils/answer/answer_reward.dart で定義している Dialogs.reward(screen) において、
// 親Widgetから渡したcontextを使ってしまうと、
// 親がdisposeされた後にその処理を実行しようとした際（たとえば１０問解いた後の次の問題の読み込み（dispose）と報酬の表示が被ってしまった場合）に
// Unhandled Exception: Looking up a deactivated widget's ancestor is unsafe. At this point the state of the widget's element tree is no longer stable.
// が発生してしまう。
// これを防ぐためには、disposeされないWidgetのcontextを Dialogs.reward(screen) で利用する必要がある。
// そのために　navigatorKey　をグローバルに定義する。
// つまり、Dialogで利用するdisposeされないWidgetのcontextとして、navigatorKey.currentContext を利用する。
// ref: https://stackoverflow.com/questions/56280736/alertdialog-without-context-in-flutter
final navigatorKey = GlobalKey<NavigatorState>();

class DiQt extends ConsumerStatefulWidget {
  const DiQt({super.key});

  @override
  DiQtState createState() => DiQtState();
}

class DiQtState extends ConsumerState<DiQt> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // localeを設定する
      await ref.read(localeProvider.notifier).setLocale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiQt',
      // 上述の Unhandled Exception: Looking up a deactivated widget's ancestor is unsafe. 対策
      navigatorKey: navigatorKey,
      // 画面全体に被さるローディングの初期化　ref： https://pub.dev/packages/flutter_easyloading
      builder: EasyLoading.init(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        // 背景を白にする
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        textTheme: SafeGoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        ),
        // Dialogを完全に白にする ref: https://note.com/waiwai_waiyade/n/naa840028dc80
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        // bottomSheetTheme の背景を完全に白にする
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        // card
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 1,
          shadowColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        // タブバーを白にする
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      // ダークモードの設定
      //darkTheme: ThemeData(
      //  colorSchemeSeed: Colors.green,
      //  useMaterial3: true,
      //  brightness: Brightness.dark,
      //),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocaleUtils.supportedLocales,
      locale: TranslationProvider.of(context).flutterLocale,
      routes: routes,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
