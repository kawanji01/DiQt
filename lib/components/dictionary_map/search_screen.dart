import 'package:booqs_mobile/components/dictionary_map/radio_list.dart';
import 'package:booqs_mobile/components/dictionary_map/search_form.dart';
import 'package:booqs_mobile/components/word/search_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryMapSearchScreen extends ConsumerStatefulWidget {
  const DictionaryMapSearchScreen({Key? key}) : super(key: key);

  @override
  DictionaryMapSearchScreenState createState() =>
      DictionaryMapSearchScreenState();
}

class DictionaryMapSearchScreenState
    extends ConsumerState<DictionaryMapSearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: const <Widget>[
          SizedBox(height: 16),
          DictionaryMapSearchForm(),
          // FlutterでRenderFlex overflowedのエラーが発生するとき、それは通常、フレックスボックス（Row、Column、Flex）内のウィジェットが利用可能なスペースを超えて拡大しようとしたときに発生する。
          // この場合、画面からはみ出すフレックスボックスの小要素をExpandedをwrapすると解決できる。
          Expanded(
            child: DictionaryMapRadioList(),
          ),
        ],
      ),
    );
  }
}
