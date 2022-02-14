import 'package:booqs_mobile/pages/chapter/show.dart';
import 'package:booqs_mobile/pages/dictionary/dictionary.dart';
import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/pages/notification/index.dart';
import 'package:booqs_mobile/pages/reminder/index.dart';
import 'package:booqs_mobile/pages/user/achievements.dart';
import 'package:booqs_mobile/pages/user/login.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:booqs_mobile/pages/user/sign_up.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:booqs_mobile/pages/word/new.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/pages/word/search_results.dart';

const indexPage = '/';
const reminderIndexPage = '/reminder/index';
const notificationIndexPage = '/notification/index';
const userMyPage = '/user/mypage';
const signUpPage = '/user/sign_up';
const loginPage = '/user/login';
const dictionaryPage = '/dictionary/dictionary';
const wordShowPage = '/words/show';
const wordNewPage = '/words/new';
const wordEditPage = '/word/edit';
const wordSearchResultsPage = '/word/search';
const chapterShowPage = '/chapters/show';
const userAchievementsPage = '/user/achievements';
const premiumPlanPage = '/user/premium_plan';

final routes = {
  indexPage: (context) => const MyHomePage(),
  reminderIndexPage: (context) => const ReminderIndexPage(),
  notificationIndexPage: (context) => const NotificationIndexPage(),
  userMyPage: (context) => const UserMyPage(),
  signUpPage: (context) => const SignUpPage(),
  loginPage: (context) => const LoginPage(),
  dictionaryPage: (context) => const DictionaryPage(),
  wordShowPage: (context) => const WordShowPage(),
  wordNewPage: (context) => const WordNewPage(),
  wordEditPage: (context) => const WordEditPage(),
  wordSearchResultsPage: (context) => const WordSearchResultsPage(),
  chapterShowPage: (context) => const ChapterShowPage(),
  userAchievementsPage: (context) => const UserAchievementsPage(),
  premiumPlanPage: (context) => const PremiumPlanPage(),
};
