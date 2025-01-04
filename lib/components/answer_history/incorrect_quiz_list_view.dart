import 'package:booqs_mobile/data/remote/answer_histories.dart';
import 'package:booqs_mobile/models/answer_history.dart';
import 'package:booqs_mobile/components/answer_history/list_quiz.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// 今日間違えた問題の数はそれほど多くはならないはずなので、スクロールなしに次々に読み込む形にする。
class AnswerHistoryIncorrectQuizListView extends StatefulWidget {
  const AnswerHistoryIncorrectQuizListView({super.key});

  @override
  State<AnswerHistoryIncorrectQuizListView> createState() =>
      _AnswerHistoryIncorrectQuizListViewState();
}

class _AnswerHistoryIncorrectQuizListViewState
    extends State<AnswerHistoryIncorrectQuizListView> {
  int _nextPagekey = 0;
  // 一度に読み込むアイテム数
  static const _pageSize = 10;
  final PagingController<int, AnswerHistory> _pagingController =
      PagingController(firstPageKey: 0); // pageのパラメーターの初期値
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  // ページに合わせてアイテムを読み込む
  Future<void> _fetchPage(int pageKey) async {
    final Map? resMap =
        await RemoteAnswerHistories.todaysMistakes(pageKey, _pageSize);
    if (resMap == null) return;

    final List<AnswerHistory> answerHistories = [];
    resMap['answer_histories']
        .forEach((e) => answerHistories.add(AnswerHistory.fromJson(e)));
    final isLastPage = answerHistories.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(answerHistories);
    } else {
      _nextPagekey = pageKey + answerHistories.length;
      //_pagingController.appendLastPage(notices);
      // pageKeyにnullを渡すことで、addPageRequestListener の発火を防ぎ、自動で次のアイテムを読み込まないようにする。
      _pagingController.appendPage(answerHistories, _nextPagekey);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, AnswerHistory>(
      pagingController: _pagingController,
      // Vertical viewport was given unbounded heightの解決 ref: https://qiita.com/code-cutlass/items/3a8b759056db1e8f7639
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<AnswerHistory>(
        itemBuilder: (context, item, index) => AnswerHistoryListQuiz(
          answerHistory: item,
        ),
        // 最下部のローディング ref: https://pub.dev/documentation/infinite_scroll_pagination/latest/infinite_scroll_pagination/PagedChildBuilderDelegate-class.html
        newPageProgressIndicatorBuilder: (_) => Container(
          padding: const EdgeInsets.only(bottom: 100),
          child: const LoadingSpinner(),
        ),
      ),
    );
  }
}
