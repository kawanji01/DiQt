import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/services/purchase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  // 環境変数を読み込む。参考： https://pub.dev/packages/flutter_dotenv
  await dotenv.load(fileName: ".env");
  // RevenueCatの初期化。
  final purchase = PurchaseService();
  purchase.initPlatformState();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // locale : https://zenn.dev/dala/books/flutter-basic-app/viewer/create-flashcard-edit
    const locale = Locale("ja", "JP");

    return MaterialApp(
      title: 'BooQs',
      locale: locale,
      // navigatorKey: Catcher.navigatorKey,
      // 画面全体に被さるローディングの初期化。参考： https://pub.dev/packages/flutter_easyloading
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
      supportedLocales: const [
        locale,
      ],
      routes: routes,
    );
  }
}
