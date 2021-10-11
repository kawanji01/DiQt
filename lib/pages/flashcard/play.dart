import 'dart:convert';
import 'package:booqs_mobile/models/flashcard.dart';
import 'package:booqs_mobile/models/flashcard_card.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlashcardPlayPage extends StatefulWidget {
  const FlashcardPlayPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, Flashcard flashcard) async {
    return Navigator.of(context).pushNamed(
      flashcardPlayPage,
      arguments: flashcard,
    );
  }

  @override
  _FlashcardPlayPageState createState() => _FlashcardPlayPageState();
}

enum AnimationType {
  none,
  flipIn,
  flipOut,
  appear,
  disappear,
}

class _FlashcardPlayPageState extends State<FlashcardPlayPage> {
  List<FlashcardCard> _flashcardCards = [];
  Flashcard? _flashcard;
  int _index = 0;
  bool _isQuestion = true;

  AnimationType _animationType = AnimationType.none;

  static const int animationDuration = 200;
  static const double margin = 20;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // パラメーターを受け取る。型をFlashcardにキャスト。
      final flashcard = ModalRoute.of(context)!.settings.arguments as Flashcard;
      _initialize(flashcard);
    });
  }

  Future _initialize(flashcard) async {
    _flashcard = flashcard;
    //final flashcardCards = await FlashcardCard
    var url = Uri.parse(
        'http://localhost:3000/ja/api/v1/mobile/dictionaries/${_flashcard?.id}');
    var res =
        await http.get(url, headers: {"Content-Type": "application/json"});
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map<String, dynamic> resMap = json.decode(res.body);
    var data = resMap['data'];
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    data.forEach((e) => _flashcardCards.add(FlashcardCard.fromJson(e)));
    //final flashcards = _flashcards;
    setState(() {
      _flashcardCards;
      _flashcard;
    });
  }

  String _getCardText() {
    final flashcardCard = _flashcardCards[_index];
    return _isQuestion ? flashcardCard.entry : flashcardCard.meaning;
  }

  Future _next() async {
    if (_isQuestion) {
      setState(() {
        _animationType = AnimationType.flipOut;
      });

      await Future.delayed(const Duration(milliseconds: animationDuration));
      setState(() {
        _isQuestion = false;
        _animationType = AnimationType.flipIn;
      });

      await Future.delayed(const Duration(milliseconds: animationDuration));
      setState(() {
        _animationType = AnimationType.none;
      });
      return;
    }

    if (_index == _flashcardCards.length - 1) {
      return;
    }

    // 消す処理
    setState(() {
      _animationType = AnimationType.disappear;
    });
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      _isQuestion = true;
      _index++;
    });
    setState(() {
      _animationType = AnimationType.appear;
    });
    await Future.delayed(const Duration(milliseconds: animationDuration));
    setState(() {
      _animationType = AnimationType.none;
    });
  }

  Widget _buildCard() {
    return AspectRatio(
      aspectRatio: 512 / 200,
      child: Stack(
        children: [
          Image.asset('assets/images/card.png'),
          Positioned.fill(
            child: Center(child: _buildCardContainer()),
          )
        ],
      ),
    );
  }

  Widget _buildCardContainer() {
    if (_flashcardCards.isEmpty) {
      return Container();
    }

    return Text(
      _getCardText(),
      style: const TextStyle(
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    );
  }

  // animation
  double _getAnimationWidth() {
    if (_animationType == AnimationType.flipOut) {
      return 1;
    }
    return MediaQuery.of(context).size.width - margin * 2;
  }

  Widget _buildCardWithAnimation() {
    if (_flashcardCards.isEmpty) {
      return Container();
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: animationDuration),
      opacity: _animationType == AnimationType.disappear ? 0 : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: animationDuration),
        width: _getAnimationWidth(),
        curve: Curves.fastOutSlowIn,
        child: _buildCard(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_flashcard?.title ?? ''),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _next,
        child: Container(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: _buildCardWithAnimation(),
            ),
          ),
        ),
      ),
    );
  }
}
