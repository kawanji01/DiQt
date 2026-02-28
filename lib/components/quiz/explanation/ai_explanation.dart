import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizExplanationAIExplanation extends ConsumerStatefulWidget {
  const QuizExplanationAIExplanation({
    super.key,
    required this.quiz,
    this.requestAIExplanation,
  });
  final Quiz quiz;
  final Future<Map> Function(int quizId)? requestAIExplanation;

  @override
  ConsumerState<QuizExplanationAIExplanation> createState() =>
      _QuizExplanationAIExplanationState();
}

class _QuizExplanationAIExplanationState
    extends ConsumerState<QuizExplanationAIExplanation> {
  bool _requested = false;
  bool _isRequesting = false;
  String? _aiExplanationText;
  String? _errorMessage;

  Future<void> _loadAIExplanation() async {
    if (_isRequesting || _requested) return;

    setState(() {
      _requested = true;
      _isRequesting = true;
      _aiExplanationText = null;
      _errorMessage = null;
    });

    final requestAIExplanation =
        widget.requestAIExplanation ?? RemoteQuizzes.aiExplanation;
    final Map resMap = await requestAIExplanation(widget.quiz.id);
    if (!mounted) return;

    if (ErrorHandler.isErrorMap(resMap)) {
      setState(() {
        _isRequesting = false;
        _errorMessage = ErrorHandler.message(resMap, useServerMessage: true);
      });
      return;
    }

    final String explanation = '${resMap['ai_explanation'] ?? ''}'.trim();
    if (explanation.isEmpty) {
      setState(() {
        _isRequesting = false;
        _errorMessage = t.quizzes.ai_explanation_generation_failed;
      });
      return;
    }

    setState(() {
      _isRequesting = false;
      _aiExplanationText = explanation;
    });
  }

  Widget _buildMessage(String message) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: Text(
        message,
        style: const TextStyle(fontSize: 12, color: Colors.black54),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isPremium = ref.watch(premiumEnabledProvider);

    Widget contents() {
      if (_requested == false) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            key: const Key('quizAiExplanationButton'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green,
              side: const BorderSide(color: Colors.green),
            ),
            onPressed: () async {
              if (isPremium == false) {
                final snackBar =
                    SnackBar(content: Text(t.shared.premium_recommendation));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                await PremiumPlanPage.push(context);
                return;
              }
              await _loadAIExplanation();
            },
            child: Text(
              t.quizzes.view_ai_explanation,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      }

      if (_isRequesting) {
        return _buildMessage(t.quizzes.generating_ai_explanation);
      }

      if (_aiExplanationText == null) {
        return _buildMessage(
            _errorMessage ?? t.quizzes.ai_explanation_generation_failed);
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownWithDictLink(
            text: _aiExplanationText ?? '',
            dictionaryId: widget.quiz.appliedDictionaryId,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontColor: Colors.black87,
            selectable: true,
          ),
        ],
      );
    }

    return Column(
      children: [
        SharedItemLabel(text: t.quizzes.ai_explanation),
        const SizedBox(height: 16),
        contents(),
        const SizedBox(height: 24),
      ],
    );
  }
}
