import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/components/quiz/item/short_answer_form.dart';
import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/drill_lap.dart';
import 'package:booqs_mobile/data/provider/solved_quiz_ids.dart';
import 'package:booqs_mobile/data/remote/quizzes.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/school.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/answer/answer_access_guard.dart';
import 'package:booqs_mobile/utils/answer/pronunciation_notification.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:record/record.dart';

enum QuizPronunciationStatus {
  idle,
  starting,
  listening,
  submitting,
  completed,
  fallback,
}

enum QuizPronunciationStopAction { ignore, defer, submit }

class QuizPronunciationFlow {
  static QuizPronunciationStopAction stopActionForStatus(
    QuizPronunciationStatus status,
  ) {
    switch (status) {
      case QuizPronunciationStatus.starting:
        return QuizPronunciationStopAction.defer;
      case QuizPronunciationStatus.listening:
        return QuizPronunciationStopAction.submit;
      case QuizPronunciationStatus.idle:
      case QuizPronunciationStatus.completed:
      case QuizPronunciationStatus.submitting:
      case QuizPronunciationStatus.fallback:
        return QuizPronunciationStopAction.ignore;
    }
  }
}

abstract class QuizPronunciationRecorder {
  Future<bool> hasPermission();
  Future<void> start({required String path});
  Future<String?> stop();
  void dispose();
}

class RecordQuizPronunciationRecorder implements QuizPronunciationRecorder {
  RecordQuizPronunciationRecorder() : _audioRecorder = AudioRecorder();

  final AudioRecorder _audioRecorder;

  @override
  Future<bool> hasPermission() {
    return _audioRecorder.hasPermission();
  }

  @override
  Future<void> start({required String path}) {
    return _audioRecorder.start(
      const RecordConfig(
        encoder: AudioEncoder.wav,
        sampleRate: 16000,
        numChannels: 1,
      ),
      path: path,
    );
  }

  @override
  Future<String?> stop() {
    return _audioRecorder.stop();
  }

  @override
  void dispose() {
    unawaited(_audioRecorder.dispose());
  }
}

class QuizItemPronunciationForm extends ConsumerStatefulWidget {
  const QuizItemPronunciationForm({
    super.key,
    required this.quiz,
    required this.unsolved,
    this.answerType,
    this.recorder,
    this.submitAnswer,
    this.showError,
    this.dispatchNotification,
    this.playReadyCue,
    this.showPaywallOnAnswerLimit = true,
  });

  final Quiz quiz;
  final bool unsolved;
  final String? answerType;
  final QuizPronunciationRecorder? recorder;
  final Future<Map> Function(File audioFile, String? answerType)? submitAnswer;
  final void Function(BuildContext context, Map resMap)? showError;
  final void Function(BuildContext context, AnswerNotification notification)?
      dispatchNotification;
  final Future<void> Function()? playReadyCue;
  final bool showPaywallOnAnswerLimit;

  @override
  ConsumerState<QuizItemPronunciationForm> createState() =>
      _QuizItemPronunciationFormState();
}

class _QuizItemPronunciationFormState
    extends ConsumerState<QuizItemPronunciationForm> {
  late final QuizPronunciationRecorder _recorder;
  late final AudioPlayer _readyCuePlayer;
  QuizPronunciationStatus _status = QuizPronunciationStatus.idle;
  String? _fallbackMessage;
  bool _stopRequestedWhileStarting = false;

  @override
  void initState() {
    super.initState();
    _recorder = widget.recorder ?? RecordQuizPronunciationRecorder();
    _readyCuePlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _recorder.dispose();
    unawaited(_readyCuePlayer.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Quiz quiz = widget.quiz;
    final String? locale = _pronunciationLocale(quiz);
    final bool directAzureSupported = _supportsDirectAzurePronunciation();
    final bool useTextFallback = _status == QuizPronunciationStatus.fallback ||
        locale == null ||
        !directAzureSupported;
    final String? fallbackMessage = _fallbackMessage ??
        (locale == null || !directAzureSupported
            ? t.quizzes.pronunciation_unavailable
            : null);

    if (useTextFallback) {
      return Column(
        children: [
          if (fallbackMessage != null) ...[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                fallbackMessage,
                style: TextStyle(color: Colors.red.shade700),
              ),
            ),
          ],
          QuizItemShortAnswerForm(
            quiz: quiz,
            unsolved: widget.unsolved,
          ),
        ],
      );
    }

    final int accuracyThreshold = quiz.pronunciationAccuracyThreshold ?? 80;
    final int completenessThreshold =
        quiz.pronunciationCompletenessThreshold ?? 80;
    final bool busy = _status == QuizPronunciationStatus.starting ||
        _status == QuizPronunciationStatus.submitting ||
        _status == QuizPronunciationStatus.completed;
    final bool listening = _status == QuizPronunciationStatus.listening;
    final bool submitting = _status == QuizPronunciationStatus.submitting;
    final Color buttonColor = submitting
        ? Colors.grey
        : listening
            ? Colors.red
            : Colors.green;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onLongPressStart: (_) => _startRecording(),
          onLongPressEnd: (_) => _stopAndSubmit(),
          onLongPressCancel: _stopAndSubmit,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: buttonColor.withValues(alpha: busy ? 0.15 : 0.25),
                  blurRadius: listening ? 18 : 12,
                  spreadRadius: listening ? 1 : 0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: submitting
                      ? const CircularProgressIndicator(
                          strokeWidth: 2.4,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Icon(
                          listening ? Icons.mic : Icons.mic_none,
                          color: Colors.white,
                        ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    _buttonLabel(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _statusLabel(),
          style: const TextStyle(fontSize: 13, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          t.quizzes.pronunciation_pass_threshold(
            accuracy_threshold: accuracyThreshold,
            completeness_threshold: completenessThreshold,
          ),
          style: const TextStyle(fontSize: 12, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          t.quizzes.pronunciation_auto_submit,
          style: const TextStyle(fontSize: 12, color: Colors.black45),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _buttonLabel() {
    switch (_status) {
      case QuizPronunciationStatus.starting:
        return t.quizzes.pronunciation_wait_for_ready;
      case QuizPronunciationStatus.listening:
        return t.quizzes.pronunciation_speak_now;
      case QuizPronunciationStatus.submitting:
        return t.quizzes.pronunciation_submitting;
      case QuizPronunciationStatus.completed:
        return t.quizzes.pronunciation_stopping;
      case QuizPronunciationStatus.fallback:
      case QuizPronunciationStatus.idle:
        return t.quizzes.pronunciation_hold_to_speak;
    }
  }

  String _statusLabel() {
    switch (_status) {
      case QuizPronunciationStatus.starting:
        return t.quizzes.pronunciation_starting;
      case QuizPronunciationStatus.listening:
        return t.quizzes.pronunciation_listening;
      case QuizPronunciationStatus.submitting:
        return t.quizzes.pronunciation_submitting;
      case QuizPronunciationStatus.completed:
        return t.quizzes.pronunciation_stopping;
      case QuizPronunciationStatus.fallback:
      case QuizPronunciationStatus.idle:
        return t.quizzes.pronunciation_idle;
    }
  }

  String? _pronunciationLocale(Quiz quiz) {
    if (quiz.langNumberOfAnswer == languageCodeMap['en']) {
      return 'en-US';
    }
    if (quiz.langNumberOfAnswer == languageCodeMap['ja']) {
      return 'ja-JP';
    }
    return null;
  }

  bool _supportsDirectAzurePronunciation() {
    if (kIsWeb) return false;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return true;
      case TargetPlatform.fuchsia:
        return false;
    }
  }

  Future<void> _startRecording() async {
    if (_status != QuizPronunciationStatus.idle) return;

    _stopRequestedWhileStarting = false;
    setState(() => _status = QuizPronunciationStatus.starting);

    try {
      final bool hasPermission = await _recorder.hasPermission();
      if (!hasPermission) {
        _switchToTextFallback(t.quizzes.pronunciation_runtime_fallback);
        return;
      }

      final String path = await _buildRecordingPath();
      await _recorder.start(path: path);
      if (!mounted) return;
      if (_stopRequestedWhileStarting) {
        await _submitCurrentRecording();
        return;
      }
      setState(() => _status = QuizPronunciationStatus.listening);
      _notifyReadyToSpeak();
    } catch (_) {
      _switchToTextFallback(t.quizzes.pronunciation_runtime_fallback);
    }
  }

  Future<void> _stopAndSubmit() async {
    switch (QuizPronunciationFlow.stopActionForStatus(_status)) {
      case QuizPronunciationStopAction.defer:
        _stopRequestedWhileStarting = true;
        return;
      case QuizPronunciationStopAction.ignore:
        return;
      case QuizPronunciationStopAction.submit:
        await _submitCurrentRecording();
    }
  }

  Future<void> _submitCurrentRecording() async {
    if (_status == QuizPronunciationStatus.submitting) {
      return;
    }

    final ProviderContainer container =
        ProviderScope.containerOf(context, listen: false);
    final int? submissionUserId =
        AnswerAccessGuard.currentPendingScopeUserIdFromContainer(container);
    setState(() => _status = QuizPronunciationStatus.submitting);

    String? path;
    bool reservedUnsolvedAnswer = false;
    try {
      path = await _recorder.stop();
      if (path == null || path.isEmpty) {
        throw StateError('Recording did not return a file path.');
      }

      final File audioFile = File(path);
      if (!mounted) return;
      if (widget.unsolved &&
          !AnswerAccessGuard.reserveUnsolvedAnswerIfAllowed(
            ref,
            userId: submissionUserId,
            showPaywall: widget.showPaywallOnAnswerLimit,
          )) {
        setState(() => _status = QuizPronunciationStatus.idle);
        return;
      }
      reservedUnsolvedAnswer = widget.unsolved;

      final Map resMap = await _submitAnswer(audioFile);
      if (ErrorHandler.isErrorMap(resMap)) {
        if (!mounted) return;
        _showError(resMap);
        if (_shouldSwitchToTextFallback(resMap)) {
          _switchToTextFallback(t.quizzes.pronunciation_runtime_fallback);
        } else {
          _resetToIdle();
        }
        return;
      }

      final User? currentUserBeforeSync = container.read(currentUserProvider);
      final bool correct = _correctFromResponse(resMap);
      if (widget.unsolved) {
        AnswerAccessGuard.consumeReservedUnsolvedAnswerFromContainer(
          container,
          userId: submissionUserId,
          correct: correct,
        );
        reservedUnsolvedAnswer = false;
      }
      final bool mountedAfterSubmission = mounted;
      final bool syncedForActiveUser = _syncSuccessfulSubmissionLocally(
        container,
        resMap,
        submissionUserId: submissionUserId,
        markSolvedQuizLocally: widget.unsolved && !mountedAfterSubmission,
      );
      if (!mountedAfterSubmission) {
        return;
      }
      if (!syncedForActiveUser) {
        _resetToIdle();
        return;
      }
      final notification = PronunciationNotification.build(
        quiz: widget.quiz,
        user: currentUserBeforeSync,
        responseMap: Map<String, dynamic>.from(resMap),
        skipAnswerAccessGuard: widget.unsolved,
        countUpdatedLocally: widget.unsolved,
      );
      if (widget.unsolved) {
        setState(() => _status = QuizPronunciationStatus.completed);
      } else {
        setState(() => _status = QuizPronunciationStatus.idle);
      }
      _dispatchNotification(notification);
    } catch (e, s) {
      if (!mounted) return;
      final Map resMap = ErrorHandler.exceptionMap(e, s);
      _showError(resMap);
      _switchToTextFallback(t.quizzes.pronunciation_runtime_fallback);
    } finally {
      if (reservedUnsolvedAnswer) {
        AnswerAccessGuard.releaseReservedUnsolvedAnswerFromContainer(
          container,
          userId: submissionUserId,
        );
      }
      if (path != null) {
        final File audioFile = File(path);
        if (await audioFile.exists()) {
          await audioFile.delete();
        }
      }
    }
  }

  Future<String> _buildRecordingPath() async {
    final Directory tempDir = Directory.systemTemp;
    return p.join(
      tempDir.path,
      'quiz_${widget.quiz.id}_${DateTime.now().millisecondsSinceEpoch}.wav',
    );
  }

  Future<Map> _submitAnswer(File audioFile) {
    final submit = widget.submitAnswer;
    if (submit != null) {
      return submit(audioFile, widget.answerType);
    }

    return RemoteQuizzes.answerPronunciation(
      quiz: widget.quiz,
      audioFile: audioFile,
      answerType: widget.answerType,
    );
  }

  void _notifyReadyToSpeak() {
    unawaited(_playReadyCue());
    unawaited(_triggerReadyHaptics());
  }

  Future<void> _playReadyCue() async {
    final playReadyCue = widget.playReadyCue;
    if (playReadyCue != null) {
      try {
        await playReadyCue();
      } catch (e) {
        debugPrint('Error playing pronunciation ready cue: $e');
      }
      return;
    }

    try {
      await _readyCuePlayer.stop();
      await _readyCuePlayer.play(AssetSource(micStartSound), volume: 0.8);
    } catch (e) {
      debugPrint('Error playing pronunciation ready cue: $e');
    }
  }

  Future<void> _triggerReadyHaptics() async {
    if (defaultTargetPlatform != TargetPlatform.iOS) return;

    try {
      await HapticFeedback.mediumImpact();
    } catch (e) {
      debugPrint('Error triggering pronunciation ready haptics: $e');
    }
  }

  bool _shouldSwitchToTextFallback(Map resMap) {
    final int? status = resMap['status'] as int?;
    if (status == null) return true;

    final String? message = resMap['message'] as String?;
    if (message == t.quizzes.pronunciation_unavailable ||
        message == t.quizzes.pronunciation_no_result) {
      return false;
    }

    if (status == 401 || status == 403 || status == 429) {
      return false;
    }

    return status < 500;
  }

  bool _correctFromResponse(Map resMap) {
    final dynamic answerCreatorJson = resMap['answer_creator'];
    if (answerCreatorJson is! Map) {
      return false;
    }

    final dynamic answerHistoryJson = answerCreatorJson['answer_history'];
    if (answerHistoryJson is! Map) {
      return false;
    }

    return answerHistoryJson['correct'] == true;
  }

  bool _syncSuccessfulSubmissionLocally(
    ProviderContainer container,
    Map resMap, {
    required int? submissionUserId,
    bool markSolvedQuizLocally = false,
  }) {
    final User? currentUser = container.read(currentUserProvider);
    if (!_submissionBelongsToCurrentUser(
      currentUser: currentUser,
      resMap: resMap,
      submissionUserId: submissionUserId,
    )) {
      return false;
    }

    final int todaysAnswersCount = container.read(todaysAnswersCountProvider);
    final int todaysCorrectAnswersCount =
        container.read(todaysCorrectAnswersCountProvider);
    final User? updatedUser = _updatedUserFromResponse(
      currentUser: currentUser,
      resMap: resMap,
    );
    if (updatedUser == null) {
      return false;
    }

    container.read(currentUserProvider.notifier).update(updatedUser);
    if (widget.unsolved) {
      container.read(todaysAnswersCountProvider.notifier).state =
          todaysAnswersCount;
      container.read(todaysCorrectAnswersCountProvider.notifier).state =
          todaysCorrectAnswersCount;
    }

    if (markSolvedQuizLocally) {
      final List<int> solvedQuizIds =
          List<int>.from(container.read(solvedQuizIdsProvider));
      if (!solvedQuizIds.contains(widget.quiz.id)) {
        container.read(solvedQuizIdsProvider.notifier).state = [
          ...solvedQuizIds,
          widget.quiz.id,
        ];
      }
      _syncDrillProgressLocally(container, resMap);
    }

    return true;
  }

  bool _submissionBelongsToCurrentUser({
    required User? currentUser,
    required Map resMap,
    required int? submissionUserId,
  }) {
    if (submissionUserId == null || currentUser?.id != submissionUserId) {
      return false;
    }

    final dynamic userJson = resMap['user'];
    if (userJson is! Map) {
      return false;
    }

    return userJson['id'] == submissionUserId;
  }

  void _syncDrillProgressLocally(ProviderContainer container, Map resMap) {
    if (widget.answerType != 'drill') {
      return;
    }

    final dynamic answerCreatorJson = resMap['answer_creator'];
    if (answerCreatorJson is! Map) {
      return;
    }

    final dynamic solvedQuizzesCount =
        answerCreatorJson['solved_quizzes_count'];
    if (solvedQuizzesCount is int) {
      container.read(drillSolvedQuizzesCountProvider.notifier).state =
          solvedQuizzesCount;
    }

    final dynamic drillLapJson = answerCreatorJson['drill_lap'];
    container.read(drillLapProvider.notifier).state = drillLapJson is Map
        ? DrillLap.fromJson(Map<String, dynamic>.from(drillLapJson))
        : null;
  }

  User? _updatedUserFromResponse({
    required User? currentUser,
    required Map resMap,
  }) {
    if (currentUser == null) {
      return null;
    }

    final dynamic userJson = resMap['user'];
    if (userJson is! Map) {
      return null;
    }
    final dynamic responseUserId = userJson['id'];
    if (responseUserId is int && responseUserId != currentUser.id) {
      return null;
    }

    final User updatedUser = User(
      id: currentUser.id,
      publicUid: currentUser.publicUid,
      name: currentUser.name,
      email: currentUser.email,
      profile: currentUser.profile,
      iconImageUrl: currentUser.iconImageUrl,
      langNumber: currentUser.langNumber,
      learningLangNumber: currentUser.learningLangNumber,
      timeZoneName: currentUser.timeZoneName,
      mailDelivered: currentUser.mailDelivered,
      amountOfExp: currentUser.amountOfExp,
      answerHistoriesCount: currentUser.answerHistoriesCount,
      todaysAnswerHistoriesCount: currentUser.todaysAnswerHistoriesCount,
      todaysCorrectAnswerHistoriesCount:
          currentUser.todaysCorrectAnswerHistoriesCount,
      wholeWeekAnswerHistoriesCount: currentUser.wholeWeekAnswerHistoriesCount,
      wholeMonthAnswerHistoriesCount:
          currentUser.wholeMonthAnswerHistoriesCount,
      answerDaysCount: currentUser.answerDaysCount,
      continuousAnswerDaysCount: currentUser.continuousAnswerDaysCount,
      continuousGoalAchievementCount:
          currentUser.continuousGoalAchievementCount,
      continuousReviewCompletionCount:
          currentUser.continuousReviewCompletionCount,
      achievementMapsCount: currentUser.achievementMapsCount,
      notesCount: currentUser.notesCount,
      premium: currentUser.premium,
      paidViaNativeApp: currentUser.paidViaNativeApp,
      unreadNotificationsCount: currentUser.unreadNotificationsCount,
      unsolvedReviewsCount: currentUser.unsolvedReviewsCount,
      reviewsCount: currentUser.reviewsCount,
      unsolvedWeaknessesCount: currentUser.unsolvedWeaknessesCount,
      weaknessesCount: currentUser.weaknessesCount,
      drillsCount: currentUser.drillsCount,
      rewardRemained: currentUser.rewardRemained,
      todaysTranslationsCount: currentUser.todaysTranslationsCount,
      todaysAiSearchesCount: currentUser.todaysAiSearchesCount,
      appFavored: currentUser.appFavored,
      appCancelReportSent: currentUser.appCancelReportSent,
      langInitialized: currentUser.langInitialized,
      reviewOnboardingShown: currentUser.reviewOnboardingShown,
      activated: currentUser.activated,
      authToken: currentUser.authToken,
      schoolId: currentUser.schoolId,
      schoolParticipation: currentUser.schoolParticipation,
      passwordBeingSet: currentUser.passwordBeingSet,
      dateCurrent: currentUser.dateCurrent,
      answerSetting: currentUser.answerSetting,
      drillInProgress: currentUser.drillInProgress,
      relationship: currentUser.relationship,
      participatingSchools: currentUser.participatingSchools == null
          ? null
          : List<School>.from(currentUser.participatingSchools!),
    );
    updatedUser.drills = currentUser.drills == null
        ? null
        : List<Drill>.from(currentUser.drills!);
    updatedUser.authToken =
        userJson['token_for_native_app'] ?? currentUser.authToken;
    updatedUser.amountOfExp =
        userJson['amount_of_exp'] ?? updatedUser.amountOfExp;
    updatedUser.answerHistoriesCount =
        userJson['answer_histories_count'] ?? updatedUser.answerHistoriesCount;
    updatedUser.todaysAnswerHistoriesCount =
        userJson['todays_answer_histories_count'] ??
            updatedUser.todaysAnswerHistoriesCount;
    updatedUser.todaysCorrectAnswerHistoriesCount =
        userJson['todays_correct_answer_histories_count'] ??
            updatedUser.todaysCorrectAnswerHistoriesCount;
    updatedUser.wholeWeekAnswerHistoriesCount =
        userJson['whole_week_answer_histories_count'] ??
            updatedUser.wholeWeekAnswerHistoriesCount;
    updatedUser.wholeMonthAnswerHistoriesCount =
        userJson['whole_month_answer_histories_count'] ??
            updatedUser.wholeMonthAnswerHistoriesCount;
    updatedUser.answerDaysCount =
        userJson['answer_days_count'] ?? updatedUser.answerDaysCount;
    updatedUser.continuousAnswerDaysCount =
        userJson['continuous_answer_days_count'] ??
            updatedUser.continuousAnswerDaysCount;
    updatedUser.continuousGoalAchievementCount =
        userJson['continuous_goal_achievement_count'] ??
            updatedUser.continuousGoalAchievementCount;
    updatedUser.continuousReviewCompletionCount =
        userJson['continuous_review_completion_count'] ??
            updatedUser.continuousReviewCompletionCount;
    updatedUser.premium = userJson['premium'] ?? updatedUser.premium;
    updatedUser.unreadNotificationsCount =
        userJson['unread_notifications_count'] ??
            updatedUser.unreadNotificationsCount;
    updatedUser.unsolvedReviewsCount =
        userJson['unsolved_reviews_count'] ?? updatedUser.unsolvedReviewsCount;
    updatedUser.reviewsCount =
        userJson['reviews_count'] ?? updatedUser.reviewsCount;
    updatedUser.unsolvedWeaknessesCount =
        userJson['unsolved_weaknesses_count'] ??
            updatedUser.unsolvedWeaknessesCount;
    updatedUser.weaknessesCount =
        userJson['weaknesses_count'] ?? updatedUser.weaknessesCount;
    updatedUser.drillsCount =
        userJson['drills_count'] ?? updatedUser.drillsCount;
    updatedUser.rewardRemained =
        userJson['reward_remained'] ?? updatedUser.rewardRemained;
    if (userJson.containsKey('drill_in_progress')) {
      final dynamic drillInProgressJson = userJson['drill_in_progress'];
      updatedUser.drillInProgress = drillInProgressJson == null
          ? null
          : Drill.fromJson(Map<String, dynamic>.from(drillInProgressJson));
    }
    return updatedUser;
  }

  void _showError(Map resMap) {
    final showError = widget.showError;
    if (showError != null) {
      showError(context, resMap);
      return;
    }

    ErrorHandler.showErrorSnackBar(
      context,
      resMap,
      serverSideMessage: true,
    );
  }

  void _dispatchNotification(AnswerNotification notification) {
    final dispatchNotification = widget.dispatchNotification;
    if (dispatchNotification != null) {
      dispatchNotification(context, notification);
      return;
    }

    notification.dispatch(context);
  }

  void _switchToTextFallback(String message) {
    if (!mounted) return;

    _stopRequestedWhileStarting = false;
    setState(() {
      _status = QuizPronunciationStatus.fallback;
      _fallbackMessage = message;
    });
  }

  void _resetToIdle() {
    if (!mounted) return;

    _stopRequestedWhileStarting = false;
    setState(() => _status = QuizPronunciationStatus.idle);
  }
}
