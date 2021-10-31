import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
