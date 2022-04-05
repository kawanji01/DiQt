import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';

class QuizExplanation extends StatelessWidget {
  const QuizExplanation({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

    // 80%の高さで表示させる
    return Container(height: height);
  }
}
