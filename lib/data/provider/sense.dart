import 'package:booqs_mobile/models/sense.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
class SenseControllerMapListState
    extends StateNotifier<List<Map<String, TextEditingController>>> {
  SenseControllerMapListState() : super([]);

  void initialize(Word? word) {
    disposeAllItems();
    if (word == null || word.senses!.isEmpty) {
      state = [];
    } else {
      // wordやsenseがある場合は、senseの数だけコントローラーを作成する
      final List<Map<String, TextEditingController>> senseList = [];
      for (Sense sense in word.senses!) {
        final Map<String, TextEditingController> senseMap = {
          'id': TextEditingController(text: sense.id.toString()),
          'gloss': TextEditingController(text: sense.gloss),
          'sentence_id': TextEditingController(
              text:
                  sense.sentenceId == null ? '' : sense.sentenceId.toString()),
          '_destroy': TextEditingController(text: 'false')
        };
        senseList.add(senseMap);
      }
      state = senseList;
    }
  }

  // Rails側のcreate, updateに必要なパラメータを返す
  Map<String, dynamic> requestParams() {
    final Map<String, dynamic> sensesAttributes = {};

    if (state.isNotEmpty) {
      for (int i = 0; i < state.length; i++) {
        final senseMap = state[i];
        final Map<String, dynamic> attributes = {};

        for (String key in senseMap.keys) {
          attributes[key] = senseMap[key]!.text;
        }
        // idが空の場合は取り除いておく
        if (attributes['id'] == '') {
          attributes.remove('id');
        }
        // 既存のsenseの場合は連番をキーとして使用し、
        // 新しいsenseの場合はタイムスタンプに連番を足したものをキーとして使用する。（タイムスタンプのみだとkeyが重複してしまう）
        final int keyId = senseMap['id']!.text.isEmpty
            ? DateTime.now().millisecondsSinceEpoch + i
            : i;
        sensesAttributes[keyId.toString()] = attributes;
      }
    }

    return sensesAttributes;
  }

  void add() {
    final List<Map<String, TextEditingController>> senseList = [];
    if (state.isEmpty == false) {
      for (Map<String, TextEditingController> senseMap in state) {
        senseList.add(senseMap);
      }
    }
    final Map<String, TextEditingController> senseMap = {
      'id': TextEditingController(),
      'gloss': TextEditingController(),
      'sentence_id': TextEditingController(),
      '_destroy': TextEditingController(text: 'false')
    };
    senseList.add(senseMap);
    state = senseList;
  }

  // すでにDBで作成されているsenseの削除フラグをtrueにする（Rails側で削除するために必要）
  void destroy({required int senseId}) {
    final List<Map<String, TextEditingController>> senseList = [];
    if (state.isEmpty == false) {
      for (Map<String, TextEditingController> senseMap in state) {
        if (senseMap['id']!.text == senseId.toString()) {
          senseMap['_destroy']!.text = 'true';
        }
        senseList.add(senseMap);
      }
    }
    state = senseList;
  }

  // まだDBで作成されていいないsenseを削除する
  void removeLast() {
    final List<Map<String, TextEditingController>> senseList = [];
    if (state.isEmpty == false) {
      for (Map<String, TextEditingController> senseMap in state) {
        senseList.add(senseMap);
      }
      disposeItem(senseList.last);
      senseList.removeLast();
    }
    state = senseList;
  }

  // 引数のitemのcontrollerをdisposeする
  void disposeItem(Map<String, TextEditingController> senseMap) {
    for (TextEditingController controller in senseMap.values) {
      controller.dispose();
    }
  }

  // 全てのcontrollerをdisposeする
  void disposeAllItems() {
    if (state.isEmpty == false) {
      List<Map<String, TextEditingController>> oldState = List.from(state);
      state = [];
      for (Map<String, TextEditingController> senseMap in oldState) {
        disposeItem(senseMap);
      }
    }
  }

  @override
  void dispose() {
    disposeAllItems();
    super.dispose();
  }
}

final senseControllerMapListProvider = StateNotifierProvider<
        SenseControllerMapListState, List<Map<String, TextEditingController>>>(
    (ref) => SenseControllerMapListState());
