import 'package:booqs_mobile/data/remote/search_histories.dart';
import 'package:booqs_mobile/models/search_history.dart';
import 'package:booqs_mobile/components/search_history/list_item.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SearchHistoryItemListView extends ConsumerStatefulWidget {
  const SearchHistoryItemListView({super.key, required this.order, required this.deviceType});
  final String order;
  final String deviceType;

  @override
  SearchHistoryItemListViewState createState() =>
      SearchHistoryItemListViewState();
}

class SearchHistoryItemListViewState
    extends ConsumerState<SearchHistoryItemListView> {
  bool _isLoading = false;
  bool _isReached = true;
  int _nextPagekey = 0;
  // 一度に読み込むアイテム数
  static const _pageSize = 10;
  final PagingController<int, SearchHistory> _pagingController =
      PagingController(
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
    if (_isLoading) return;
    if (_isReached == false) return;
    _isLoading = true;

    final Map resMap = await RemoteSearchHistories.index(
        pageKey, _pageSize, widget.order, widget.deviceType);
    // ref: https://github.com/EdsonBueno/infinite_scroll_pagination/issues/64
    if (!mounted) return;

    if (resMap.containsKey('error')) {
      return setState(() {
        _isLoading = false;
        _isReached = false;
      });
    }
    final List<SearchHistory> searchHistories = [];
    if (resMap.containsKey('search_histories')) {
      resMap['search_histories']
          .forEach((e) => searchHistories.add(SearchHistory.fromJson(e)));
    }
    final isLastPage = searchHistories.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(searchHistories);
    } else {
      _nextPagekey = pageKey + searchHistories.length;
      // pageKeyにnullを渡すことで、addPageRequestListener の発火を防ぎ、自動で次のアイテムを読み込まないようにする。
      _pagingController.appendPage(searchHistories, _nextPagekey);
    }

    setState(() {
      _isReached = false;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    Widget loader() {
      // ref: https://qiita.com/kikuchy/items/07d10394a4f7aa2a3836
      return VisibilityDetector(
        key: const Key("for detect visibility"),
        onVisibilityChanged: (info) {
          // [visibleFraction] 0で非表示、１で完全表示。0.1は上部が少し表示されている状態 ref: https://pub.dev/documentation/visibility_detector/latest/visibility_detector/VisibilityInfo/visibleFraction.html
          if (info.visibleFraction > 0.1) {
            if (_isLoading) return;
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

    return PagedListView<int, SearchHistory>(
      pagingController: _pagingController,
      // Vertical viewport was given unbounded heightの解決 ref: https://qiita.com/code-cutlass/items/3a8b759056db1e8f7639
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<SearchHistory>(
        itemBuilder: (context, item, index) => SearchHistoryListItem(
          searchHistory: item,
        ),
        // 最下部のローディング ref: https://pub.dev/documentation/infinite_scroll_pagination/latest/infinite_scroll_pagination/PagedChildBuilderDelegate-class.html
        newPageProgressIndicatorBuilder: (_) => loader(),
      ),
    );
  }
}
