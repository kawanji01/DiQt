import 'package:booqs_mobile/pages/flashcard/create.dart';
import 'package:booqs_mobile/pages/home.dart';

const indexPage = '/';
const flashcardCreatePage = '/flashcard/create';

final routes = {
  indexPage: (context) => const MyHomePage(),
  flashcardCreatePage: (context) => const CreateFlashcardPage(),
};
