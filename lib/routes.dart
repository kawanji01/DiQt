import 'package:booqs_mobile/pages/flashcard/create.dart';
import 'package:booqs_mobile/pages/flashcard/edit.dart';
import 'package:booqs_mobile/pages/home.dart';

const indexPage = '/';
const flashcardCreatePage = '/flashcard/create';
const flashcardEditPage = '/flashcard/edit';

final routes = {
  indexPage: (context) => const MyHomePage(),
  flashcardCreatePage: (context) => const CreateFlashcardPage(),
  flashcardEditPage: (context) => const EditFlashcardPage(),
};
