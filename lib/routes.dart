import 'package:booqs_mobile/pages/answer_analysis/index.dart';
import 'package:booqs_mobile/pages/answer_history/todays_mistakes.dart';
import 'package:booqs_mobile/pages/chapter/index.dart';
import 'package:booqs_mobile/pages/chapter/show.dart';
import 'package:booqs_mobile/pages/dictionary/dictionary.dart';
import 'package:booqs_mobile/pages/drill/show.dart';
import 'package:booqs_mobile/pages/drill/solved.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/pages/notice/home.dart';
import 'package:booqs_mobile/pages/notice/index.dart';
import 'package:booqs_mobile/pages/review/all.dart';
import 'package:booqs_mobile/pages/review/index.dart';
import 'package:booqs_mobile/pages/review/scheduled.dart';
import 'package:booqs_mobile/pages/user/achievements.dart';
import 'package:booqs_mobile/pages/session/login.dart';
import 'package:booqs_mobile/pages/user/edit.dart';
import 'package:booqs_mobile/pages/user/menu.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:booqs_mobile/pages/session/sign_up.dart';
import 'package:booqs_mobile/pages/user/show.dart';
import 'package:booqs_mobile/pages/weakness/index.dart';
import 'package:booqs_mobile/pages/weakness/solved.dart';
import 'package:booqs_mobile/pages/weakness/unsolved.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:booqs_mobile/pages/word/new.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/pages/word/search_results.dart';

// ホーム
const indexPage = '/';
// 通知
const noticeIndexPage = '/notice/index';
const noticeHomePage = '/notice/home';
// セッション
const signUpPage = '/session/sign_up';
const loginPage = '/session/login';
// 辞書
const dictionaryShowPage = '/dictionary/show';
// ワード
const wordShowPage = '/word/show';
const wordNewPage = '/word/new';
const wordEditPage = '/word/edit';
const wordSearchResultsPage = '/word/search';
// チャプター
const chapterIndexPage = '/chapter/index';
const chapterShowPage = '/chapter/show';
// ユーザー
const userMyPage = '/user/mypage';
const userShowPage = '/user/show';
const userAchievementsPage = '/user/achievements';
const userEditPage = '/user/edit';
const userMenuPage = '/user/menu';
const userPremiumPlanPage = '/user/premium_plan';
// 問題集
const drillUnsolvedPage = '/drill/unsolved';
const drillSolvedPage = '/drill/solved';
const drillShowPage = '/drill/show';
// 復習
const reviewIndexPage = '/review/index';
const reviewScheduledPage = '/review/scheduled';
const reviewAllPage = '/review/all';
// 苦手な問題
const weaknessIndexPage = '/weakness/index';
const weaknessUnsolvedPage = '/weakness/unsolved';
const weaknessSolvedPage = '/weakness/solved';
// 解答履歴
const answerHistoryTodaysMistakesPage = '/answer_history/todays_mistakes';
// 解答分析
const answerAnalysisIndexPage = 'answer_analysis/index';

final routes = {
  indexPage: (context) => const MyHomePage(),
  noticeIndexPage: (context) => const NoticeIndexPage(),
  noticeHomePage: (context) => const NoticeHomePage(),
  userMyPage: (context) => const UserMyPage(),
  signUpPage: (context) => const SignUpPage(),
  loginPage: (context) => const LoginPage(),
  dictionaryShowPage: (context) => const DictionaryPage(),
  wordShowPage: (context) => const WordShowPage(),
  wordNewPage: (context) => const WordNewPage(),
  wordEditPage: (context) => const WordEditPage(),
  wordSearchResultsPage: (context) => const WordSearchResultsPage(),
  chapterIndexPage: (context) => const ChapterIndexPage(),
  chapterShowPage: (context) => const ChapterShowPage(),
  userShowPage: (context) => const UserShowPage(),
  userAchievementsPage: (context) => const UserAchievementsPage(),
  userEditPage: (context) => const UserEditPage(),
  userMenuPage: (context) => const UserMenuPage(),
  userPremiumPlanPage: (context) => const PremiumPlanPage(),
  drillUnsolvedPage: (context) => const DrillUnsolvedPage(),
  drillSolvedPage: (context) => const DrillSolvedPage(),
  drillShowPage: (context) => const DrillShowPage(),
  reviewIndexPage: (context) => const ReviewIndexPage(),
  reviewScheduledPage: (context) => const ReviewScheduledPage(),
  reviewAllPage: (context) => const ReviewAllPage(),
  weaknessIndexPage: (context) => const WeaknessIndexPage(),
  weaknessUnsolvedPage: (context) => const WeaknessUnsolvedPage(),
  weaknessSolvedPage: (context) => const WeaknessSolvedPage(),
  answerHistoryTodaysMistakesPage: (context) =>
      const AnswerHistoryTodaysMistakesPage(),
  answerAnalysisIndexPage: (context) => const AnswerAnalysisIndexPage(),
};
