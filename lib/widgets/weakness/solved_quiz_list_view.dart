import 'package:booqs_mobile/data/provider/weakness.dart';
import 'package:booqs_mobile/data/remote/weaknesses.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/weakness/list_quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:visibility_detector/visibility_detector.dart';

class WeaknessSolvedQuizListView extends ConsumerStatefulWidget {
  const WeaknessSolvedQuizListView({Key? key}) : super(key: key);

  @override
  _WeaknessSolvedQuizListViewState createState() =>
      _WeaknessSolvedQuizListViewState();
}

class _WeaknessSolvedQuizListViewState
    extends ConsumerState<WeaknessSolvedQuizListView> {
  bool _isLoading = false;
  bool _isReached = true;
  int _nextPagekey = 0;
  // 一度に読み込むアイテム数
  static const _pageSize = 10;
  final PagingController<int, Weakness> _pagingController = PagingController(
      firstPageKey: 0, invisibleItemsThreshold: 100); // pageのパラメーターの初期値
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  // ページに合わせてアイテムを読み込む
  Future<void> _fetchPage(int pageKey) async {
    print('nextPageKey: $_nextPagekey');
    if (_isLoading) return;
    if (_isReached == false) return;
    print('_fetchPage isLoading: false');
    _isLoading = true;

    final String order = ref.watch(weaknessOrderProvider);
    final Map? resMap =
        await RemoteWeaknesses.solved(pageKey, _pageSize, order);
    if (resMap == null) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isReached = false;
        });
      }
      return;
    }
    final List<Weakness> weaknesses = [];
    resMap['weaknesses'].forEach((e) => weaknesses.add(Weakness.fromJson(e)));
    final isLastPage = weaknesses.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(weaknesses);
    } else {
      _nextPagekey = pageKey + weaknesses.length;
      //_pagingController.appendLastPage(notices);
      // pageKeyにnullを渡すことで、addPageRequestListener の発火を防ぎ、自動で次のアイテムを読み込まないようにする。
      _pagingController.appendPage(weaknesses, _nextPagekey);
    }
    if (mounted) {
      setState(() {
        _isReached = false;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    Widget _loader() {
      // ref: https://qiita.com/kikuchy/items/07d10394a4f7aa2a3836
      return VisibilityDetector(
        key: const Key("for detect visibility"),
        onVisibilityChanged: (info) {
          // [visibleFraction] 0で非表示、１で完全表示。0.1は上部が少し表示されている状態 ref: https://pub.dev/documentation/visibility_detector/latest/visibility_detector/VisibilityInfo/visibleFraction.html
          if (info.visibleFraction > 0.1) {
            if (_isLoading) return print('visibleFraction _isLoading: true');
            print('visibleFraction _isLoading: false');
            setState(() {
              _isReached = true;
            });

            // 最下部までスクロールしたら、次のアイテムを読み込む ref: https://pub.dev/documentation/infinite_scroll_pagination/latest/infinite_scroll_pagination/PagingController/notifyPageRequestListeners.html
            _pagingController.notifyPageRequestListeners(_nextPagekey);
          }
        },
        child: Container(
          padding: const EdgeInsets.only(bottom: 100),
          child: const LoadingSpinner(),
        ),
      );
    }

    return PagedListView<int, Weakness>(
      pagingController: _pagingController,
      // Vertical viewport was given unbounded heightの解決 ref: https://qiita.com/code-cutlass/items/3a8b759056db1e8f7639
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<Weakness>(
        itemBuilder: (context, item, index) => WeaknessListQuiz(
          weakness: item,
        ),
        // 最下部のローディング ref: https://pub.dev/documentation/infinite_scroll_pagination/latest/infinite_scroll_pagination/PagedChildBuilderDelegate-class.html
        newPageProgressIndicatorBuilder: (_) => _loader(),
      ),
    );
  }
}
