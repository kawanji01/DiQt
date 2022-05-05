import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/button/large_button.dart';
import 'package:flutter/material.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, Dictionary dictionary) async {
    return Navigator.of(context).pushNamed(
      dictionaryShowPage,
      arguments: dictionary,
    );
  }

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  @override
  Widget build(BuildContext context) {
    // 辞書の取得
    Dictionary getDictionary() {
      return ModalRoute.of(context)!.settings.arguments as Dictionary;
    }

    final _dictionary = getDictionary();

    Widget _acceptedWordRequestsButton() {
      final String btnText = '承認済（${_dictionary.acceptedWordRequestsCount}）';
      final String redirectPath =
          'dictionaries/${_dictionary.publicUid}/accepted_word_requests';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: LargeButton(btnText: btnText),
      );
    }

    Widget _pendingWordRequestsButton() {
      final String btnText = '審査中（${_dictionary.pendingWordRequestsCount}）';
      final String redirectPath =
          'dictionaries/${_dictionary.publicUid}/pending_word_requests';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: LargeButton(btnText: btnText),
      );
    }

    Widget _acceptedSentenceRequestsButton() {
      final String btnText =
          '承認済（${_dictionary.acceptedSentenceRequestsCount}）';
      final String redirectPath =
          'dictionaries/${_dictionary.publicUid}/accepted_sentence_requests';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: LargeButton(btnText: btnText),
      );
    }

    Widget _pendingSentenceRequestsButton() {
      final String btnText = '審査中（${_dictionary.pendingSentenceRequestsCount}）';
      final String redirectPath =
          'dictionaries/${_dictionary.publicUid}/pending_sentence_requests';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: LargeButton(btnText: btnText),
      );
    }

    Widget _acceptedQuizRequestsButton() {
      final String btnText = '承認済（${_dictionary.acceptedQuizRequestsCount}）';
      final String redirectPath =
          'dictionaries/${_dictionary.publicUid}/accepted_quiz_requests';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: LargeButton(btnText: btnText),
      );
    }

    Widget _pendingQuizRequestsButton() {
      final String btnText = '審査中（${_dictionary.pendingQuizRequestsCount}）';
      final String redirectPath =
          'dictionaries/${_dictionary.publicUid}/pending_quiz_requests';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: LargeButton(btnText: btnText),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_dictionary.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 32),
              const Text(
                '項目の改善履歴',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              _acceptedWordRequestsButton(),
              const SizedBox(height: 32),
              _pendingWordRequestsButton(),
              const SizedBox(height: 48),
              const Text(
                '例文の改善履歴',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              _acceptedSentenceRequestsButton(),
              const SizedBox(height: 32),
              _pendingSentenceRequestsButton(),
              const SizedBox(height: 48),
              const Text(
                '問題の改善履歴',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              _acceptedQuizRequestsButton(),
              const SizedBox(height: 32),
              _pendingQuizRequestsButton(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
