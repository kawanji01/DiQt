import 'package:booqs_mobile/data/remote/dictionaries.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/widgets/dictionary/no_more_sentences.dart';
import 'package:booqs_mobile/widgets/dictionary/no_sentences_found.dart';
import 'package:booqs_mobile/widgets/sentence/list_item.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DictionarySentenceListView extends StatefulWidget {
  const DictionarySentenceListView(
      {Key? key, required this.dictionaryId, required this.keyword})
      : super(key: key);

  final int dictionaryId;
  final String keyword;

  @override
  State<DictionarySentenceListView> createState() =>
      _DictionarySentenceListViewState();
}

class _DictionarySentenceListViewState
    extends State<DictionarySentenceListView> {
  bool _isLoading = false;
  bool _isReached = true;
  int _nextPagekey = 0;
  // 一度に読み込むアイテム数
  static const _pageSize = 10;
  // pageのパラメーターの初期値
  final PagingController<int, Sentence> _pagingController =
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

    final Map? resMap = await RemoteDictionaries.sentenceSearch(
        widget.dictionaryId, widget.keyword, pageKey, _pageSize);
    if (resMap == null) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isReached = false;
        });
      }
      return;
    }
    final List<Sentence> sentences = [];
    resMap['sentences'].forEach((e) => sentences.add(Sentence.fromJson(e)));
    final isLastPage = sentences.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(sentences);
    } else {
      _nextPagekey = pageKey + sentences.length;
      // _pagingController.appendLastPage(notices);
      // pageKeyにnullを渡すことで、addPageRequestListener の発火を防ぎ、自動で次のアイテムを読み込まないようにする。
      _pagingController.appendPage(sentences, _nextPagekey);
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
    final int _dictionaryId = widget.dictionaryId;
    final String _keyword = widget.keyword;
    //
    Widget _loader() {
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

    // 区切り線
    Widget _divider() {
      return Container(
        padding: const EdgeInsets.only(bottom: 40),
        child: const Divider(
          thickness: 1,
        ),
      );
    }

    return PagedListView.separated(
      pagingController: _pagingController,
      separatorBuilder: (context, index) => _divider(),
      padding: const EdgeInsets.only(top: 40),
      // Vertical viewport was given unbounded heightの解決 ref: https://qiita.com/code-cutlass/items/3a8b759056db1e8f7639
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<Sentence>(
          itemBuilder: (context, item, index) => SentenceListItem(
                sentence: item,
                isShow: false,
              ),
          // 最下部のローディング ref: https://pub.dev/documentation/infinite_scroll_pagination/latest/infinite_scroll_pagination/PagedChildBuilderDelegate-class.html
          newPageProgressIndicatorBuilder: (_) => _loader(),
          // 検索結果なし
          noItemsFoundIndicatorBuilder: (_) => DictionaryNoSentencesFound(
              dictionaryId: _dictionaryId, keyword: _keyword),
          // すべての検索結果の読み込み完了
          noMoreItemsIndicatorBuilder: (_) =>
              DictionaryNoMoreSentences(dictionaryId: _dictionaryId)),
    );
  }
}
