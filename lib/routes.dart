import 'package:booqs_mobile/pages/flashcard/create.dart';
import 'package:booqs_mobile/pages/flashcard/edit.dart';
import 'package:booqs_mobile/pages/flashcard/edit_card.dart';
import 'package:booqs_mobile/pages/flashcard/play.dart';
import 'package:booqs_mobile/pages/home.dart';

const indexPage = '/';
const flashcardCreatePage = '/flashcard/create';
const flashcardEditPage = '/flashcard/edit';
const flashcardCardEditPage = '/flashcard/edit-card';
const flashcardPlayPage = '/flashcard/play';

final routes = {
  indexPage: (context) => const MyHomePage(),
  flashcardCreatePage: (context) => const CreateFlashcardPage(),
  flashcardEditPage: (context) => const EditFlashcardPage(),
  flashcardCardEditPage: (context) => const EditFlashcardCardPage(),
  flashcardPlayPage: (context) => const FlashcardPlayPage(),
};
