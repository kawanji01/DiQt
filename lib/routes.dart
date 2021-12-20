import 'package:booqs_mobile/pages/dictionary/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/search_en_ja.dart';
import 'package:booqs_mobile/pages/dictionary/word.dart';
import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/pages/notification/index.dart';
import 'package:booqs_mobile/pages/reminder/index.dart';
import 'package:booqs_mobile/pages/user/login.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/pages/user/sign_up.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:booqs_mobile/pages/word/word_search.dart';

const indexPage = '/';
const searchEnJaPage = '/dictionary/search_en_ja';
const reminderIndexPage = '/reminder/index';
const notificationIndexPage = '/notification/index';
const userMyPage = '/user/mypage';
const signUpPage = '/user/sign_up';
const loginPage = '/user/login';
const dictionaryPage = '/dictionary/dictionary';
const wordPage = '/dictionary/word';
const wordEditPage = '/word/edit';
const wordSearchPage = '/word/search';

final routes = {
  indexPage: (context) => const MyHomePage(),
  searchEnJaPage: (context) => const SearchEnJaPage(),
  reminderIndexPage: (context) => const ReminderIndexPage(),
  notificationIndexPage: (context) => const NotificationIndexPage(),
  userMyPage: (context) => const UserMyPage(),
  signUpPage: (context) => const SignUpPage(),
  loginPage: (context) => const LoginPage(),
  dictionaryPage: (context) => const DictionaryPage(),
  wordPage: (context) => const WordPage(),
  wordEditPage: (context) => const WordEditPage(),
  wordSearchPage: (context) => const WordSearchPage(),
};
