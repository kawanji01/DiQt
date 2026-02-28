import 'package:booqs_mobile/components/lang/small_translation_buttons.dart';
import 'package:booqs_mobile/components/sentence/form/translation_buttons.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../builders/user.dart';

Future<void> _pumpSmallTranslationButtons(
  WidgetTester tester, {
  AppLocale locale = AppLocale.en,
}) async {
  LocaleSettings.setLocaleSync(locale);
  await tester.pumpWidget(
    ProviderScope(
      child: TranslationProvider(
        child: const MaterialApp(
          home: Scaffold(
            body: LangSmallTranslationButtons(
              original: 'hello',
              sourceLangNumber: 1,
              targetLangNumber: 0,
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

Future<void> _pumpSentenceTranslationButtons(
  WidgetTester tester, {
  AppLocale locale = AppLocale.en,
}) async {
  final CurrentUserState userState = CurrentUserState()
    ..update(UserBuilder().build());
  LocaleSettings.setLocaleSync(locale);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentUserProvider.overrideWith((ref) => userState),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: SentenceFormTranslationButtons(
              originalController: TextEditingController(text: 'hello'),
              translationController: TextEditingController(),
              sourceLangNumber: 1,
              targetLangNumber: 0,
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  group('Translation button unification', () {
    testWidgets('Small translation buttons are unified to a single label',
        (WidgetTester tester) async {
      await _pumpSmallTranslationButtons(tester);

      expect(find.text('Translate'), findsOneWidget);
      expect(find.text('Google Translation'), findsNothing);
      expect(find.text('DeepL Translation'), findsNothing);
      expect(find.text(' / '), findsNothing);
    });

    testWidgets(
        'Sentence form translation buttons are unified to a single label',
        (WidgetTester tester) async {
      await _pumpSentenceTranslationButtons(tester);

      expect(find.text('Translate'), findsOneWidget);
      expect(find.text('Google Translation'), findsNothing);
      expect(find.text('DeepL Translation'), findsNothing);
      expect(find.text(' / '), findsNothing);
    });
  });
}
