import 'package:booqs_mobile/components/sentence/setting_form/list_item.dart';
import 'package:booqs_mobile/components/shared/no_items_found_indicator.dart';
import 'package:booqs_mobile/components/shared/no_more_items_indicator.dart';
import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:visibility_detector/visibility_detector.dart';

// 編集画面を複数跨ぐこともできるので、フォームでは値を画面内で完結させるために、状態管理にProviderは利用しない。
class SentenceSettingFormListView extends StatefulWidget {
  const SentenceSettingFormListView(
      {Key? key, required this.keyword, required this.dictionary})
      : super(key: key);
  final String keyword;
  final Dictionary dictionary;

  @override
  State<SentenceSettingFormListView> createState() =>
      _SentenceSettingFormListViewState();
}

class _SentenceSettingFormListViewState
    extends State<SentenceSettingFormListView> {
  bool _isLoading = false;
  bool _isReached = true;
  int _nextPagekey = 0;
  // 一度に読み込むアイテム数
  static const _pageSize = 10;
  final PagingController<int, Sentence> _pagingController = PagingController(
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

    final int dictionaryId = widget.dictionary.id;
    final String keyword = widget.keyword;
    final Map? resMap =
        await RemoteSentences.search(keyword, dictionaryId, pageKey, _pageSize);
    if (!mounted) return;
    if (resMap == null) {
      return setState(() {
        _isLoading = false;
        _isReached = false;
      });
    }
    final List<Sentence> sentences = [];
    if (resMap['sentences'] != null) {
      resMap['sentences'].forEach((e) => sentences.add(Sentence.fromJson(e)));
    }

    // print(activities.length);
    final isLastPage = sentences.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(sentences);
    } else {
      _nextPagekey = pageKey + sentences.length;
      //_pagingController.appendLastPage(notices);
      // pageKeyにnullを渡すことで、addPageRequestListener の発火を防ぎ、自動で次のアイテムを読み込まないようにする。
      _pagingController.appendPage(sentences, _nextPagekey);
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

    return PagedListView<int, Sentence>(
      pagingController: _pagingController,
      // Vertical viewport was given unbounded heightの解決 ref: https://qiita.com/code-cutlass/items/3a8b759056db1e8f7639
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<Sentence>(
        itemBuilder: (context, item, index) => SentenceSettingFormListItem(
          sentence: item,
        ),
        // 最下部のローディング ref: https://pub.dev/documentation/infinite_scroll_pagination/latest/infinite_scroll_pagination/PagedChildBuilderDelegate-class.html
        newPageProgressIndicatorBuilder: (_) => loader(),
        noItemsFoundIndicatorBuilder: (_) => NoItemsFoundIndicator(
          itemName: t.sentences.sentences,
        ),
        noMoreItemsIndicatorBuilder: (_) => NoMoreItemsIndicator(
          itemName: t.sentences.sentences,
        ),
      ),
    );
  }
}
