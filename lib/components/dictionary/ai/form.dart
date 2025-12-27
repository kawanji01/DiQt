import 'dart:async';
import 'package:booqs_mobile/components/dictionary/ai/prompt_select.dart';
import 'package:booqs_mobile/components/dictionary/ai/results.dart';
import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/data/remote/langs.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/ai_searcher.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryAIForm extends ConsumerStatefulWidget {
  const DictionaryAIForm(
      {super.key, required this.keyword, required this.dictionary});
  final String keyword;
  final Dictionary dictionary;

  @override
  ConsumerState<DictionaryAIForm> createState() => _DictionaryAIFormState();
}

class _DictionaryAIFormState extends ConsumerState<DictionaryAIForm> {
  bool _isRequesting = false;
  AISearcher? _aiSearcher;
  StreamSubscription<String>? _aiSearchSubscription;

  Future<void> _performAISearch() async {
    await _aiSearchSubscription?.cancel();
    if (!mounted) return;
    final String promptKey = ref.read(dictionaryAIPromptKeyProvider);
    setState(() {
      _aiSearcher = AISearcher(promptKey: promptKey, results: '');
      _isRequesting = true;
    });
    bool hasError = false;
    final Stream<String> stream = RemoteLangs.aiSearchStream(
      keyword: widget.keyword,
      sourceLangNumber: widget.dictionary.langNumberOfEntry,
      targetLangNumber: widget.dictionary.langNumberOfMeaning,
      promptKey: promptKey,
    );
    _aiSearchSubscription = stream.listen((String delta) {
      if (!mounted) return;
      setState(() {
        _aiSearcher?.results = '${_aiSearcher?.results ?? ''}$delta';
      });
    }, onError: (Object error) {
      hasError = true;
      if (!mounted) return;
      final Map<String, dynamic> errorMap = error is Map
          ? Map<String, dynamic>.from(error)
          : {'status': 500, 'message': '$error'};
      ErrorHandler.showErrorToast(context, errorMap);
      setState(() {
        _isRequesting = false;
      });
    }, onDone: () {
      if (!mounted) return;
      if (!hasError) {
        ref.read(todaysAiSearchesCountProvider.notifier).state += 1;
      }
      setState(() {
        _isRequesting = false;
      });
    });
  }

  // プレミアムプランページに遷移
  void _moveToPremiumPlan() {
    final snackBar = SnackBar(
        content: Text(t.lang
            .ai_searches_restricted(number: aiSearchesCountLimitForFreeUsers)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    PremiumPlanPage.push(context);
  }

  @override
  void dispose() {
    _aiSearchSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 無料ユーザーが翻訳上限を超えたかどうかを判定
    final bool aiSearchesLimited = ref.watch(premiumEnabledProvider) == false &&
        ref.watch(todaysAiSearchesCountProvider) >=
            aiSearchesCountLimitForFreeUsers;

    return Column(
      children: [
        const DictionaryAIPromptSelect(),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (_isRequesting) return;

              if (aiSearchesLimited) {
                _moveToPremiumPlan();
              } else {
                _performAISearch();
              }
            },
            child: Text(t.lang.ask_ai,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        DictionaryAIResults(
            aiSearcher: _aiSearcher, isRequesting: _isRequesting),
      ],
    );
  }
}
