import 'package:booqs_mobile/i18n/translations.g.dart';

String localizePronunciationErrorType(
  String errorType,
  Translations translations,
) {
  final String normalizedErrorType = errorType.trim();
  switch (normalizedErrorType.toLowerCase()) {
    case 'mispronunciation':
      return translations
          .answerAnalyses.pronunciation_error_types.mispronunciation;
    case 'unexpectedbreak':
      return translations
          .answerAnalyses.pronunciation_error_types.unexpected_break;
    case 'missingbreak':
      return translations
          .answerAnalyses.pronunciation_error_types.missing_break;
    case 'monotone':
      return translations.answerAnalyses.pronunciation_error_types.monotone;
    case 'omission':
      return translations.answerAnalyses.pronunciation_error_types.omission;
    case 'insertion':
      return translations.answerAnalyses.pronunciation_error_types.insertion;
    default:
      return normalizedErrorType;
  }
}

String localizePronunciationErrorTypes(
  dynamic errorTypes,
  Translations translations,
) {
  final List<dynamic> rawTypes;
  if (errorTypes is String) {
    rawTypes = errorTypes.split(',');
  } else if (errorTypes is Iterable) {
    rawTypes = errorTypes.toList();
  } else if (errorTypes == null) {
    rawTypes = const [];
  } else {
    rawTypes = [errorTypes];
  }

  final Set<String> seen = <String>{};
  final List<String> localizedTypes = <String>[];

  for (final dynamic rawType in rawTypes) {
    final String localizedType =
        localizePronunciationErrorType(rawType.toString(), translations);
    if (localizedType.isEmpty || seen.contains(localizedType)) {
      continue;
    }
    seen.add(localizedType);
    localizedTypes.add(localizedType);
  }

  return localizedTypes.join(', ');
}
