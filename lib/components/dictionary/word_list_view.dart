import 'package:booqs_mobile/data/remote/dictionaries.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/dictionary/no_more_words.dart';
import 'package:booqs_mobile/components/dictionary/no_words_found.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/word/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DictionaryWordListView extends ConsumerStatefulWidget {
  const DictionaryWordListView(
      {Key? key, required this.dictionaryId, required this.keyword})
      : super(key: key);
  final int dictionaryId;
  final String keyword;

  @override
  DictionaryWordListViewState createState() => DictionaryWordListViewState();
}

class DictionaryWordListViewState
    extends ConsumerState<DictionaryWordListView> {
  bool _isLoading = false;
  bool _isReached = true;
  int _nextPagekey = 0;
  // 一度に読み込むアイテム数
  static const _pageSize = 10;
  // pageのパラメーターの初期値
  final PagingController<int, Word> _pagingController =
      PagingController(firstPageKey: 0);
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

    final Map? resMap = await RemoteDictionaries.search(
        widget.dictionaryId, widget.keyword, pageKey, _pageSize);
    if (!mounted) return;
    if (resMap == null) {
      return setState(() {
        _isLoading = false;
        _isReached = false;
      });
    }
    final List<Word> words = [];
    resMap['words'].forEach((e) => words.add(Word.fromJson(e)));

    final isLastPage = words.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(words);
    } else {
      _nextPagekey = pageKey + words.length;
      // _pagingController.appendLastPage(notices);
      // pageKeyにnullを渡すことで、addPageRequestListener の発火を防ぎ、自動で次のアイテムを読み込まないようにする。
      _pagingController.appendPage(words, _nextPagekey);
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
    final int dictionaryId = widget.dictionaryId;
    final String keyword = widget.keyword;
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

    return PagedListView<int, Word>(
      pagingController: _pagingController,
      // Vertical viewport was given unbounded heightの解決 ref: https://qiita.com/code-cutlass/items/3a8b759056db1e8f7639
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<Word>(
          itemBuilder: (context, item, index) => WordListItem(
                word: item,
              ),
          // 最下部のローディング ref: https://pub.dev/documentation/infinite_scroll_pagination/latest/infinite_scroll_pagination/PagedChildBuilderDelegate-class.html
          newPageProgressIndicatorBuilder: (_) => loader(),
          // 検索結果なし
          noItemsFoundIndicatorBuilder: (_) => DictionaryNoWordsFound(
              dictionaryId: dictionaryId, keyword: keyword),
          // すべての検索結果の読み込み完了
          noMoreItemsIndicatorBuilder: (_) => DictionaryNoMoreWords(
              dictionaryId: dictionaryId, keyword: keyword)),
    );
  }
}
