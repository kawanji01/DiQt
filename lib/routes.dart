import 'package:booqs_mobile/pages/answer_analysis/index.dart';
import 'package:booqs_mobile/pages/answer_history/todays_mistakes.dart';
import 'package:booqs_mobile/pages/chapter/index.dart';
import 'package:booqs_mobile/pages/custom_section/show.dart';
import 'package:booqs_mobile/pages/quiz_request/dictionary.dart';
import 'package:booqs_mobile/pages/quiz_request/quiz.dart';
import 'package:booqs_mobile/pages/quiz_request/show.dart';
import 'package:booqs_mobile/pages/school/show.dart';
import 'package:booqs_mobile/pages/chapter/show.dart';
import 'package:booqs_mobile/pages/dictionary/guideline.dart';
import 'package:booqs_mobile/pages/dictionary/sentence_search_results.dart';
import 'package:booqs_mobile/pages/dictionary/show.dart';
import 'package:booqs_mobile/pages/dictionary/word_search_results.dart';
import 'package:booqs_mobile/pages/drill/show.dart';
import 'package:booqs_mobile/pages/drill/solved.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:booqs_mobile/pages/home/home_page.dart';
import 'package:booqs_mobile/pages/home/community_page.dart';
import 'package:booqs_mobile/pages/note/index.dart';
import 'package:booqs_mobile/pages/notice/home.dart';
import 'package:booqs_mobile/pages/notice/index.dart';
import 'package:booqs_mobile/pages/quiz/edit.dart';
import 'package:booqs_mobile/pages/quiz/show.dart';
import 'package:booqs_mobile/pages/review/all.dart';
import 'package:booqs_mobile/pages/review/index.dart';
import 'package:booqs_mobile/pages/review/scheduled.dart';
import 'package:booqs_mobile/pages/sentence/edit.dart';
import 'package:booqs_mobile/pages/sentence/new.dart';
import 'package:booqs_mobile/pages/sentence/show.dart';
import 'package:booqs_mobile/pages/sentence_request/dictionary.dart';
import 'package:booqs_mobile/pages/sentence_request/show.dart';
import 'package:booqs_mobile/pages/sentence_request/sentence.dart';
import 'package:booqs_mobile/pages/session/transition.dart';
import 'package:booqs_mobile/pages/user/achievements.dart';
import 'package:booqs_mobile/pages/session/log_in.dart';
import 'package:booqs_mobile/pages/user/cancellation.dart';
import 'package:booqs_mobile/pages/user/contract_details.dart';
import 'package:booqs_mobile/pages/user/drills.dart';
import 'package:booqs_mobile/pages/user/edit.dart';
import 'package:booqs_mobile/pages/user/menu.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:booqs_mobile/pages/session/sign_up.dart';
import 'package:booqs_mobile/pages/user/search.dart';
import 'package:booqs_mobile/pages/user/show.dart';
import 'package:booqs_mobile/pages/weakness/index.dart';
import 'package:booqs_mobile/pages/weakness/solved.dart';
import 'package:booqs_mobile/pages/weakness/unsolved.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:booqs_mobile/pages/word/new.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/pages/word_request/dictionary.dart';
import 'package:booqs_mobile/pages/word_request/show.dart';
import 'package:booqs_mobile/pages/word_request/word.dart';
import 'package:booqs_mobile/pages/word_tag/show.dart';
import 'package:booqs_mobile/pages/search_history/index.dart';

// ホーム
const indexPage = '/';
const communityPage = '/home/community';

// 通知
const noticeIndexPage = '/notice/index';
const noticeHomePage = '/notice/home';
// セッション
const sessionSignUpPage = '/session/sign_up';
const sessionLogInPage = '/session/log_in';
const sessionTransitionPage = '/session/transition';

// 辞書
const dictionaryShowPage = '/dictionary/show';
const dictionaryWordSearchResultsPage = '/dictionary/word_search_results';
const dictionarySentenceSearchResultsPage =
    '/dictionary/sentence_search_results';
const dictionaryGuidelinePage = '/dictionary/guideline';
// テスト
const dictionarySpeechTestPage = '/dictionary/speech_test';
// 辞書の項目
const wordShowPage = '/word/show';
const wordNewPage = '/word/new';
const wordEditPage = '/word/edit';
const wordSearchResultsPage = '/word/search';
// 例文
const sentenceNewPage = '/sentence/new';
const sentenceEditPage = '/sentence/edit';
const sentenceShowPage = '/sentence/show';
// 辞書の項目のリクエスト
const wordRequestDictionaryPage = '/word_request/dictionary';
const wordRequestWordPage = '/word_request/word';
const wordRequestShowPage = '/word_request/show';
// 例文のリクエスト
const sentenceRequestDictionaryPage = '/sentence_request/dictionary';
const sentenceRequestSentencePage = '/sentence_request/sentence';
const sentenceRequestShowPage = '/sentence_request/show';
// 問題のリクエスト
const quizRequestDictionaryPage = '/quiz_request/dictionary';
const quizRequestSchoolPage = '/quiz_request/dictionary';
const quizRequestDrillPage = '/quiz_request/dictionary';
const quizRequestQuizPage = '/quiz_request/word';
const quizRequestShowPage = '/quiz_request/show';

// 教室
const schoolShowPage = '/school/show';
// チャプター
const chapterIndexPage = '/chapter/index';
const chapterShowPage = '/chapter/show';
const chapterDrillsPage = '/chapter/drills';
// カスタムセクション
const customSectionShowPage = '/custom_section/show';
// WordTag
const wordTagShowPage = '/word_tag/show';
// ユーザー
const userMyPage = '/user/mypage';
const userShowPage = '/user/show';
const userDrillsPage = '/user/drills';
const userAchievementsPage = '/user/achievements';
const userEditPage = '/user/edit';
const userMenuPage = '/user/menu';
const userSearchPage = '/user/search';
const userPremiumPlanPage = '/user/premium_plan';
const userContractDetailsPage = '/user/contract_details';
const userCancellationPage = '/user/cancellation';
// 問題集
const drillUnsolvedPage = '/drill/unsolved';
const drillSolvedPage = '/drill/solved';
const drillShowPage = '/drill/show';
// 問題
const quizEditPage = '/quiz/edit';
const quizShowPage = '/quiz/show';
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
// 検索履歴
const searchHistoryIndexPage = 'search_history/index';
// ノート
const noteIndexPage = 'note/index';

final routes = {
  indexPage: (context) => const HomePage(),
  communityPage: (context) => const HomeCommunityPage(),
  // Notification(Notice)
  noticeIndexPage: (context) => const NoticeIndexPage(),
  noticeHomePage: (context) => const NoticeHomePage(),
  // Session
  sessionSignUpPage: (context) => const SessionSignUpPage(),
  sessionLogInPage: (context) => const SessionLogInPage(),
  sessionTransitionPage: (context) => const SessionTransitionPage(),
  // Dictionary
  dictionaryShowPage: (context) => const DictionaryShowPage(),
  dictionaryWordSearchResultsPage: (context) =>
      const DictionaryWordSearchResultsPage(),
  dictionarySentenceSearchResultsPage: (context) =>
      const DictionarySentenceSearchResultsPage(),
  dictionaryGuidelinePage: (context) => const DictionaryGuidelinePage(),
  // Word
  wordShowPage: (context) => const WordShowPage(),
  wordNewPage: (context) => const WordNewPage(),
  wordEditPage: (context) => const WordEditPage(),
  // Sentence
  sentenceNewPage: (context) => const SentenceNewPage(),
  sentenceEditPage: (context) => const SentenceEditPage(),
  sentenceShowPage: (context) => const SentenceShowPage(),
  // WordRequest
  wordRequestDictionaryPage: (context) => const WordRequestDictionaryPage(),
  wordRequestWordPage: (context) => const WordRequestWordPage(),
  wordRequestShowPage: (context) => const WordRequestShowPage(),
  // SentenceRequest
  sentenceRequestDictionaryPage: (context) =>
      const SentenceRequestDictionaryPage(),
  sentenceRequestSentencePage: (context) => const SentenceRequestSentencePage(),
  sentenceRequestShowPage: (context) => const SentenceRequestShowPage(),
  // QuizRequest
  quizRequestDictionaryPage: (context) => const QuizRequestDictionaryPage(),
  quizRequestQuizPage: (context) => const QuizRequestQuizPage(),
  quizRequestShowPage: (context) => const QuizRequestShowPage(),

  // School
  schoolShowPage: (context) => const SchoolShowPage(),
  // Chapter
  chapterIndexPage: (context) => const ChapterIndexPage(),
  chapterShowPage: (context) => const ChapterShowPage(),
  // CustomSection
  customSectionShowPage: (context) => const CustomSectionShowPage(),
  // WordTag
  wordTagShowPage: (context) => const WordTagShowPage(),

  // User
  userMyPage: (context) => const UserMyPage(),
  userShowPage: (context) => const UserShowPage(),
  userDrillsPage: (context) => const UserDrillsPage(),
  userAchievementsPage: (context) => const UserAchievementsPage(),
  userEditPage: (context) => const UserEditPage(),
  userMenuPage: (context) => const UserMenuPage(),
  userSearchPage: (context) => const UserSearchPage(),
  userPremiumPlanPage: (context) => const PremiumPlanPage(),
  userContractDetailsPage: (context) => const UserContractDetailsPage(),
  userCancellationPage: (context) => const UserCancellationPage(),
  // Drill
  drillUnsolvedPage: (context) => const DrillUnsolvedPage(),
  drillSolvedPage: (context) => const DrillSolvedPage(),
  drillShowPage: (context) => const DrillShowPage(),
  // Quiz
  quizEditPage: (context) => const QuizEditPage(),
  quizShowPage: (context) => const QuizShowPage(),
  // Review
  reviewIndexPage: (context) => const ReviewIndexPage(),
  reviewScheduledPage: (context) => const ReviewScheduledPage(),
  reviewAllPage: (context) => const ReviewAllPage(),
  // Weakness
  weaknessIndexPage: (context) => const WeaknessIndexPage(),
  weaknessUnsolvedPage: (context) => const WeaknessUnsolvedPage(),
  weaknessSolvedPage: (context) => const WeaknessSolvedPage(),
  // AnswerHistory
  answerHistoryTodaysMistakesPage: (context) =>
      const AnswerHistoryTodaysMistakesPage(),
  answerAnalysisIndexPage: (context) => const AnswerAnalysisIndexPage(),
  // SearchHistory
  searchHistoryIndexPage: (context) => const SearchHistoryIndexPage(),
  // Note
  noteIndexPage: (context) => const NoteIndexPage(),
};
