import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/chat_service.dart';
import 'package:flutter/material.dart';

//
class DictionaryAISearch extends StatefulWidget {
  const DictionaryAISearch(
      {super.key, required this.keyword, required this.dictionary});
  final String keyword;
  final Dictionary dictionary;

  @override
  State<DictionaryAISearch> createState() => _DictionaryAISearchState();
}

class _DictionaryAISearchState extends State<DictionaryAISearch> {
  bool _isRequesting = false;
  List<String> collectedChunks = []; // このリストにストリームからのチャンクを保存する。

  Stream<String?> chatGPTStream(
      {required String prompt, required int version}) {
    final StreamController<String?> controller = StreamController<String?>();
    String bufferedChunk = ""; // 不完全なJSONへの対策用

    bool isValidJson(String input) {
      try {
        json.decode(input);
        return true;
      } catch (e) {
        return false;
      }
    }

    Future<void> fetchData() async {
      try {
        final http.StreamedResponse streamedResponse =
            await ChatService.stream(prompt: prompt, version: version);

        if (streamedResponse.statusCode == 200) {
          streamedResponse.stream.transform(utf8.decoder).listen((chunk) {
            bufferedChunk += chunk; // 不完全なJSON対策に、バッファにデータを追加

            // バッファ内のチャンクを取得
            List<String> splitChunks = bufferedChunk
                .split('\n')
                .where((line) => line.trim().startsWith('data: '))
                .toList();

            for (String singleChunk in splitChunks) {
              String modifiedText =
                  singleChunk.replaceFirst("data:", "").trim();

              if (modifiedText == '[DONE]') {
                // END OF STREAM
                continue;
              }

              if (!isValidJson(modifiedText)) {
                // このチャンクが不完全なJSONである場合、このイテレーションをスキップして次のチャンクを待ちます。
                continue;
              }

              Map<String, dynamic> parsedData = json.decode(modifiedText);

              if (parsedData['choices'] != null &&
                  parsedData['choices'].isNotEmpty) {
                String? content = parsedData['choices'][0]['delta']['content'];
                print('content: $content');

                if (content != null) {
                  collectedChunks.add(content);
                }
                controller.add(content);
              }

              // ここでバッファからこのチャンクを削除
              bufferedChunk = bufferedChunk.replaceFirst(singleChunk, "");
            }
          }, onDone: () {
            controller.close();
          }, onError: (error) {
            controller.addError(error);
          });
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        print("error $e");
        controller.addError(e);
        controller.close();
      }
    }

    fetchData();

    return controller.stream;
  }

  void _performAISearch() {
    setState(() => _isRequesting = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_isRequesting) {
      return StreamBuilder<String?>(
        stream:
            chatGPTStream(prompt: '${widget.keyword}の意味を教えてください。', version: 3),
        builder: (context, snapshot) {
          // ストリームからの最初のデータが届いたときに、LoadingSpinnerを非表示にする
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSpinner();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          // ここで結果を出力する。
          String fullReplyContent = collectedChunks.join();
          return SelectableText(fullReplyContent,
              style: const TextStyle(fontSize: 14, color: Colors.black87));
        },
      );
    } else {
      return ElevatedButton(
        onPressed: _performAISearch,
        child: const Text('AI Search'),
      );
    }
  }
}
