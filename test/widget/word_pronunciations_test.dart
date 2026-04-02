import 'package:booqs_mobile/components/word/item/pronunciations.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Word buildWord({
  String? pinyin,
  String? bopomofo,
  String? jyutping,
}) {
  return Word(
    id: 1,
    dictionaryId: 1,
    entry: '你好',
    langNumberOfEntry: 2,
    meaning: 'hello',
    langNumberOfMeaning: 0,
    pinyin: pinyin,
    bopomofo: bopomofo,
    jyutping: jyutping,
    wordRequestsCount: 0,
    acceptedWordRequestsCount: 0,
    pendingWordRequestsCount: 0,
  );
}

Future<void> pumpPronunciations(
  WidgetTester tester, {
  required AppLocale locale,
  required Word word,
}) async {
  await tester.runAsync(() async {
    await LocaleSettings.setLocale(locale);
  });
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: WordPronunciations(word: word),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  group('WordPronunciations', () {
    testWidgets('pinyin, bopomofo, jyutping を表示する',
        (WidgetTester tester) async {
      await pumpPronunciations(
        tester,
        locale: AppLocale.en,
        word: buildWord(
          pinyin: 'nǐ hǎo',
          bopomofo: 'ㄋㄧˇ ㄏㄠˇ',
          jyutping: 'nei5 hou2',
        ),
      );

      expect(find.text('Pinyin:'), findsOneWidget);
      expect(find.text('nǐ hǎo'), findsOneWidget);
      expect(find.text('Bopomofo:'), findsOneWidget);
      expect(find.text('ㄋㄧˇ ㄏㄠˇ'), findsOneWidget);
      expect(find.text('Jyutping:'), findsOneWidget);
      expect(find.text('nei5 hou2'), findsOneWidget);
    });

    testWidgets('bopomofo が null または空文字なら表示しない', (WidgetTester tester) async {
      await pumpPronunciations(
        tester,
        locale: AppLocale.en,
        word: buildWord(
          pinyin: 'nǐ hǎo',
          bopomofo: '   ',
          jyutping: 'nei5 hou2',
        ),
      );

      expect(find.text('Bopomofo:'), findsNothing);
      expect(find.text('ㄋㄧˇ ㄏㄠˇ'), findsNothing);
      expect(find.text('Pinyin:'), findsOneWidget);
      expect(find.text('Jyutping:'), findsOneWidget);
    });

    testWidgets('日本語ロケールでは注音符号ラベルを使う', (WidgetTester tester) async {
      await pumpPronunciations(
        tester,
        locale: AppLocale.ja,
        word: buildWord(bopomofo: 'ㄋㄧˇ ㄏㄠˇ'),
      );

      expect(find.text('注音符号:'), findsOneWidget);
      expect(find.text('ㄋㄧˇ ㄏㄠˇ'), findsOneWidget);
    });
  });
}
