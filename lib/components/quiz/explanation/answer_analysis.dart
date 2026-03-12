import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/weakness/setting_button.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:booqs_mobile/utils/pronunciation_error_type_localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizExplanationAnswerAnalysis extends ConsumerWidget {
  const QuizExplanationAnswerAnalysis({super.key, required this.quiz});
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String locale = ref.watch(localeProvider);
    final AnswerAnalysis? answerAnalysis = quiz.answerAnalysis;
    final Weakness? weakness = quiz.weakness;

    Widget answersCount() {
      if (answerAnalysis == null) {
        return Text(t.answerAnalyses.not_yet_answered,
            style: const TextStyle(fontSize: 16));
      }
      final int answersCount = answerAnalysis.answerHistoriesCount;
      return Text(
        t.answerAnalyses.answers_count(count: answersCount),
        style: const TextStyle(
            fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
      );
    }

    Widget incorrectAnswersCount() {
      if (answerAnalysis == null) {
        return Container();
      }
      final int incorrectAnswersCount =
          answerAnalysis.incorrectAnswerHistoriesCount;
      return Text(
        t.answerAnalyses.incorrect_answers_count(count: incorrectAnswersCount),
        style: const TextStyle(
            fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
      );
    }

    Widget correctAnswerRate() {
      if (answerAnalysis == null) {
        return Container();
      }
      final double correctAnswerRate = answerAnalysis.correctAnswerRate;
      Color color = Colors.blue;
      if (correctAnswerRate < 50) {
        color = Colors.red;
      }

      return Text(
        '${t.answerAnalyses.correct_answer_rate}： $correctAnswerRate%',
        style:
            TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold),
      );
    }

    Widget lastAnswerDate() {
      if (answerAnalysis == null) {
        return Container();
      }

      final String answeredAt = DateTimeFormatter.createTimeAgoString(
          dateTime: answerAnalysis.lastAnsweredAt, locale: locale);

      Color color = Colors.red;

      String lastAnswerAt = t.answerAnalyses.incorrect_at(time_ago: answeredAt);
      if (answerAnalysis.lastAnswerCorrect) {
        color = Colors.blue;
        lastAnswerAt = t.answerAnalyses.correct_at(time_ago: answeredAt);
      }

      return Text(
        lastAnswerAt,
        style: TextStyle(
            fontSize: 16, color: color, fontWeight: FontWeight.normal),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: SharedItemLabel(
            text: t.answerAnalyses.answer_analyses,
            icon: Icons.analytics_outlined,
          ),
        ),
        const SizedBox(height: 8),
        answersCount(),
        const SizedBox(height: 4),
        incorrectAnswersCount(),
        const SizedBox(height: 4),
        correctAnswerRate(),
        const SizedBox(height: 4),
        lastAnswerDate(),
        if (answerAnalysis != null &&
            _hasPronunciationAnalysis(answerAnalysis)) ...[
          const SizedBox(height: 20),
          _PronunciationAnalysisSections(answerAnalysis: answerAnalysis),
        ],
        const SizedBox(height: 16),
        WeaknessSettingButton(quizId: quiz.id, weakness: weakness),
        const SizedBox(height: 80),
      ],
    );
  }

  bool _hasPronunciationAnalysis(AnswerAnalysis answerAnalysis) {
    return answerAnalysis.pronunciationIncorrectReasons.isNotEmpty ||
        answerAnalysis.pronunciationWordAssessmentRows.isNotEmpty ||
        answerAnalysis.pronunciationPhonemeComparisonRows.isNotEmpty ||
        answerAnalysis.pronunciationReferenceHighlightSegments.isNotEmpty ||
        answerAnalysis.pronunciationWordHighlights.isNotEmpty ||
        answerAnalysis.pronunciationConnectedSpeechFeedbacks.isNotEmpty ||
        answerAnalysis.lastPronunciationPayload != null;
  }
}

class _PronunciationAnalysisSections extends StatelessWidget {
  const _PronunciationAnalysisSections({required this.answerAnalysis});

  final AnswerAnalysis answerAnalysis;

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = [];
    final incorrectReasons = answerAnalysis.pronunciationIncorrectReasons;
    if (incorrectReasons.isNotEmpty) {
      sections.add(_section(
        title: t.answerAnalyses.pronunciation_incorrect_reason,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: incorrectReasons
              .map(
                (reason) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text('・${_pronunciationIncorrectReasonText(reason)}'),
                ),
              )
              .toList(),
        ),
      ));
    }

    final referenceSegments =
        answerAnalysis.pronunciationReferenceHighlightSegments;
    final wordHighlights = answerAnalysis.pronunciationWordHighlights;
    if (referenceSegments.isNotEmpty || wordHighlights.isNotEmpty) {
      sections.add(_section(
        title: t.answerAnalyses.pronunciation_word_highlight_title,
        note: t.answerAnalyses.pronunciation_word_highlight_note,
        child: referenceSegments.isNotEmpty
            ? _buildRichSegments(referenceSegments)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: wordHighlights
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: _buildRichSegments(
                          _mapList(item['segments']),
                          fallbackText: item['word']?.toString() ?? '',
                        ),
                      ),
                    )
                    .toList(),
              ),
      ));
    }

    final wordAssessments = answerAnalysis.pronunciationWordAssessmentRows;
    if (wordAssessments.isNotEmpty) {
      sections.add(_section(
        title: t.answerAnalyses.pronunciation_word_feedback_title,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: wordAssessments
              .map(
                (assessment) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    '・${_pronunciationWordFeedback(assessment)}',
                    style: TextStyle(
                      color: assessment['issue'] == true
                          ? Colors.red.shade700
                          : Colors.black87,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ));
    }

    final connectedSpeech =
        answerAnalysis.pronunciationConnectedSpeechFeedbacks;
    if (connectedSpeech.isNotEmpty) {
      sections.add(_section(
        title: t.answerAnalyses.connected_speech_feedback_title,
        note: t.answerAnalyses.connected_speech_feedback_note,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: connectedSpeech
              .map(
                (feedback) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '・${_connectedSpeechCategoryLabel(feedback['category']?.toString() ?? '')}: ${_connectedSpeechMessage(feedback)}',
                  ),
                ),
              )
              .toList(),
        ),
      ));
    }

    final phonemeRows = answerAnalysis.pronunciationPhonemeComparisonRows;
    if (phonemeRows.isNotEmpty) {
      sections.add(_section(
        title: t.answerAnalyses.pronunciation_phoneme_comparison_title,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: phonemeRows
              .map(
                (row) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        child: _buildRichSegments(
                          _mapList(row['word_segments']),
                          fallbackText: row['word']?.toString() ?? '',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${t.answerAnalyses.pronunciation_phoneme_expected}: ${row['expected_phoneme']}',
                      ),
                      Text(
                        '${t.answerAnalyses.pronunciation_phoneme_actual}: ${row['actual_phoneme'] ?? t.answerAnalyses.pronunciation_phoneme_not_available}',
                      ),
                      Text(
                        '${t.answerAnalyses.pronunciation_phoneme_score}: ${row['score'] ?? '-'}',
                      ),
                      Text(
                        '${t.answerAnalyses.pronunciation_phoneme_status}: ${_phonemeStatusText(row)}',
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: sections,
    );
  }

  Widget _section({
    required String title,
    required Widget child,
    String? note,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          if (note != null) ...[
            const SizedBox(height: 4),
            Text(
              note,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _mapList(dynamic value) {
    if (value is! List) return [];

    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  Widget _buildRichSegments(List<Map<String, dynamic>> segments,
      {String fallbackText = ''}) {
    if (segments.isEmpty) {
      return Text(fallbackText);
    }

    return Text.rich(
      TextSpan(
        children: segments
            .map(
              (segment) => TextSpan(
                text: segment['text']?.toString() ?? '',
                style: TextStyle(
                  fontWeight: segment['issue'] == true
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: segment['issue'] == true
                      ? Colors.red.shade700
                      : Colors.black87,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  String _pronunciationIncorrectReasonText(Map<String, dynamic> reason) {
    final String key = reason['key']?.toString() ?? '';
    final Map<String, dynamic> params = reason['params'] is Map
        ? Map<String, dynamic>.from(reason['params'])
        : {};
    switch (key) {
      case 'mode_not_enabled':
        return t.answerAnalyses.pronunciation_reason.mode_not_enabled;
      case 'recognized_text_mismatch':
        return t.answerAnalyses.pronunciation_reason.recognized_text_mismatch(
          expected: params['expected'] ?? '',
          actual: params['actual'] ?? '',
        );
      case 'accuracy_low':
        return t.answerAnalyses.pronunciation_reason.accuracy_low(
          score: params['score'] ?? '-',
          threshold: params['threshold'] ?? '-',
        );
      case 'completeness_low':
        return t.answerAnalyses.pronunciation_reason.completeness_low(
          score: params['score'] ?? '-',
          threshold: params['threshold'] ?? '-',
        );
      case 'word_errors_detected':
        return t.answerAnalyses.pronunciation_reason.word_errors_detected;
      case 'word_errors_detected_with_type':
        return t.answerAnalyses.pronunciation_reason
            .word_errors_detected_with_type(
          error_types:
              localizePronunciationErrorTypes(params['error_types'], t),
        );
      case 'recognized_text_blank':
        return t.answerAnalyses.pronunciation_reason.recognized_text_blank;
      default:
        return t.answerAnalyses.pronunciation_reason.unknown;
    }
  }

  String _localizedPronunciationErrorType(String errorType) {
    return localizePronunciationErrorType(errorType, t);
  }

  String _pronunciationWordFeedback(Map<String, dynamic> assessment) {
    final String word = assessment['word']?.toString() ?? '';
    final Object score = assessment['score'] ?? '-';
    final String? errorType = assessment['error_type']?.toString();
    if (errorType != null && errorType.isNotEmpty) {
      return t.answerAnalyses.pronunciation_word_feedback_with_error(
        word: word,
        score: score,
        error_type: _localizedPronunciationErrorType(errorType),
      );
    }
    return t.answerAnalyses
        .pronunciation_word_feedback(word: word, score: score);
  }

  String _connectedSpeechCategoryLabel(String category) {
    switch (category) {
      case 'linking':
        return t.answerAnalyses.connected_speech_categories.linking;
      case 'assimilation':
        return t.answerAnalyses.connected_speech_categories.assimilation;
      case 'reduction':
        return t.answerAnalyses.connected_speech_categories.reduction;
      case 'flapping':
        return t.answerAnalyses.connected_speech_categories.flapping;
      case 'contraction':
        return t.answerAnalyses.connected_speech_categories.contraction;
      default:
        return category;
    }
  }

  String _connectedSpeechMessage(Map<String, dynamic> feedback) {
    final Map<String, dynamic> evidence = feedback['evidence'] is Map
        ? Map<String, dynamic>.from(feedback['evidence'])
        : {};
    final String boundaryLabel = feedback['boundary_label']?.toString() ??
        '${evidence['left_word'] ?? ''} ${evidence['right_word'] ?? ''}'.trim();
    final String targetWord = evidence['target_word']?.toString() ??
        evidence['left_word']?.toString() ??
        '';
    final String example = evidence['example']?.toString() ?? '';
    final String messageKey = feedback['message_key']?.toString() ?? '';
    switch (messageKey) {
      case 'linking_unexpected_break':
        return t.answerAnalyses.connected_speech_messages
            .linking_unexpected_break(boundary: boundaryLabel);
      case 'linking_missing_break':
        return t.answerAnalyses.connected_speech_messages
            .linking_missing_break(boundary: boundaryLabel);
      case 'linking_cv':
        return t.answerAnalyses.connected_speech_messages
            .linking_cv(boundary: boundaryLabel);
      case 'linking_cc':
        return t.answerAnalyses.connected_speech_messages
            .linking_cc(boundary: boundaryLabel);
      case 'linking_vv_y_glide':
        return t.answerAnalyses.connected_speech_messages
            .linking_vv_y_glide(boundary: boundaryLabel);
      case 'linking_vv_w_glide':
        return t.answerAnalyses.connected_speech_messages
            .linking_vv_w_glide(boundary: boundaryLabel);
      case 'linking_vv_generic':
        return t.answerAnalyses.connected_speech_messages
            .linking_vv_generic(boundary: boundaryLabel);
      case 'linking_general':
        return t.answerAnalyses.connected_speech_messages
            .linking_general(boundary: boundaryLabel);
      case 'assimilation_bilabial':
        return t.answerAnalyses.connected_speech_messages
            .assimilation_bilabial(boundary: boundaryLabel);
      case 'assimilation_velar':
        return t.answerAnalyses.connected_speech_messages
            .assimilation_velar(boundary: boundaryLabel);
      case 'assimilation_palatal_t':
        return t.answerAnalyses.connected_speech_messages
            .assimilation_palatal_t(boundary: boundaryLabel);
      case 'assimilation_palatal_d':
        return t.answerAnalyses.connected_speech_messages
            .assimilation_palatal_d(boundary: boundaryLabel);
      case 'assimilation_palatal_s':
        return t.answerAnalyses.connected_speech_messages
            .assimilation_palatal_s(boundary: boundaryLabel);
      case 'assimilation_palatal_z':
        return t.answerAnalyses.connected_speech_messages
            .assimilation_palatal_z(boundary: boundaryLabel);
      case 'reduction_function_word':
        return t.answerAnalyses.connected_speech_messages
            .reduction_function_word(
          target_word: targetWord,
        );
      case 'flapping_internal':
        return t.answerAnalyses.connected_speech_messages
            .flapping_internal(target_word: targetWord);
      case 'flapping_boundary':
        return t.answerAnalyses.connected_speech_messages
            .flapping_boundary(boundary: boundaryLabel);
      case 'contraction_pair':
        return t.answerAnalyses.connected_speech_messages.contraction_pair(
          boundary: boundaryLabel,
          example: example,
        );
      default:
        return boundaryLabel;
    }
  }

  String _phonemeStatusText(Map<String, dynamic> row) {
    if (row['actual_phoneme'] == null ||
        row['actual_phoneme'].toString().isEmpty) {
      return t.answerAnalyses.pronunciation_phoneme_status_not_available;
    }
    if (row['mismatch'] == true) {
      return t.answerAnalyses.pronunciation_phoneme_status_mismatch;
    }
    final String? errorType = row['error_type']?.toString();
    if (errorType != null && errorType.isNotEmpty) {
      return _localizedPronunciationErrorType(errorType);
    }
    return t.answerAnalyses.pronunciation_phoneme_status_low_score;
  }
}
