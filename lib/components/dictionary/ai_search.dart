import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/chat_service.dart';
import 'package:flutter/material.dart';

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
  List<String> collectedChunks = []; // このリストにストリームからのチャンクを保存します。

  Stream<String?> chatGPTStream(
      {required String prompt, required int version}) {
    final StreamController<String?> controller = StreamController<String?>();

    Future<void> fetchData() async {
      try {
        final http.StreamedResponse streamedResponse =
            await ChatService.stream(prompt: prompt, version: version);

        if (streamedResponse.statusCode == 200) {
          streamedResponse.stream.transform(utf8.decoder).listen((chunk) {
            // START
            List<String> splitChunks =
                chunk.split('\n').where((s) => s.trim().isNotEmpty).toList();

            for (String singleChunk in splitChunks) {
              try {
                if (singleChunk.startsWith('data: ')) {
                  singleChunk = singleChunk.substring(6); // 'data: 'の部分を取り除く
                }
                Map<String, dynamic> parsedData = json.decode(singleChunk);

                if (parsedData['choices'] != null &&
                    parsedData['choices'].isNotEmpty) {
                  String? content =
                      parsedData['choices'][0]['delta']['content'];
                  print('content: $content');
                  // `content`を保存する
                  if (content != null) {
                    collectedChunks.add(content);
                  }
                  // Send each chunk to the StreamController
                  controller.add(content);
                }
              } catch (e) {
                // print("Error decoding chunk: $e");
                // デコード中にエラーが発生した場合、エラーメッセージを表示して次のチャンクに移ります
                continue;
              }
            }
            // END
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
          // ここで結果を出力します。
          String fullReplyContent = collectedChunks.join();
          return Text(fullReplyContent);
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
