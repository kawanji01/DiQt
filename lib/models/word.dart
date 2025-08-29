import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/grammatical_tag.dart';
import 'package:booqs_mobile/models/pos_tag.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sense.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word_tag.dart';

class Word {
  Word({
    required this.id,
    required this.dictionaryId,
    this.sentenceId,
    this.posTagId,
    required this.entry,
    required this.langNumberOfEntry,
    this.entrySsml,
    required this.meaning,
    this.meaningJa,
    this.meaningEn,
    required this.langNumberOfMeaning,
    this.explanation = '',
    this.meaningImageUrl,
    this.pos,
    this.ipa,
    this.reading,
    this.etymologies,
    this.synonyms,
    this.antonyms,
    this.related,
    this.sensesJson,
    this.sensesTags,
    this.formsList,
    required this.wordRequestsCount,
    required this.acceptedWordRequestsCount,
    required this.pendingWordRequestsCount,
    // 結合したテーブル
    this.sentence,
    this.dictionary,
    this.posTag,
    this.quiz,
    this.reversedQuiz,
    this.wordTags,
    this.senses,
    this.grammaticalTags,
  });

  int id;
  int dictionaryId;
  int? sentenceId;
  int? posTagId;
  String entry;
  String? entrySsml;
  int langNumberOfEntry;
  String? entryAudioUrl;
  String meaning;
  String? meaningJa;
  String? meaningEn;
  int langNumberOfMeaning;
  String? explanation;
  String? meaningImageUrl;
  String? pos;
  String? ipa;
  String? reading;
  String? etymologies;
  String? synonyms;
  String? antonyms;
  String? related;
  String? sensesJson;
  List? sensesTags;
  List? formsList;
  int wordRequestsCount;
  int acceptedWordRequestsCount;
  int pendingWordRequestsCount;
  Sentence? sentence;
  Dictionary? dictionary;
  PosTag? posTag;
  Quiz? quiz;
  Quiz? reversedQuiz;
  List<WordTag>? wordTags;
  List<Sense>? senses;
  List<GrammaticalTag>? grammaticalTags;

  Word.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        sentenceId = json['sentence_id'],
        posTagId = json['pos_tag_id'],
        entry = json['entry'],
        langNumberOfEntry = json['lang_number_of_entry'],
        entrySsml = json['entry_ssml'],
        entryAudioUrl = json['entry_audio_url'],
        meaning = json['meaning'],
        // 後方互換性を保つため、新旧両方のカラム名に対応
        meaningJa = json['meaning_ja'] ?? json['ja_meaning'],
        meaningEn = json['meaning_en'] ?? json['en_meaning'],
        langNumberOfMeaning = json['lang_number_of_meaning'],
        explanation = json['explanation'],
        meaningImageUrl = json['meaning_image_url'],
        pos = json['pos'],
        ipa = json['ipa'],
        reading = json['reading'],
        etymologies = json['etymologies'],
        synonyms = json['synonyms'],
        antonyms = json['antonyms'],
        related = json['related'],
        sensesJson = json['senses_json'],
        sensesTags = json['senses_tags'],
        formsList = json['forms_list'],
        wordRequestsCount = json['word_requests_count'],
        acceptedWordRequestsCount = json['accepted_word_requests_count'],
        pendingWordRequestsCount = json['pending_word_requests_count'],
        sentence = json['sentence'] == null
            ? null
            : Sentence.fromJson(json['sentence']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['dictionary']),
        posTag =
            json['pos_tag'] == null ? null : PosTag.fromJson(json['pos_tag']),
        quiz = json['quiz'] == null ? null : Quiz.fromJson(json['quiz']),
        reversedQuiz = json['reversed_quiz'] == null
            ? null
            : Quiz.fromJson(json['reversed_quiz']),
        wordTags = json['word_tags'] == null
            ? []
            : json['word_tags']
                .map<WordTag>((e) => WordTag.fromJson(e))
                .toList(),
        senses = json['senses'] == null
            ? []
            : json['senses'].map<Sense>((e) => Sense.fromJson(e)).toList(),
        grammaticalTags = json['grammatical_tags'] == null
            ? []
            : json['grammatical_tags']
                .map<GrammaticalTag>((e) => GrammaticalTag.fromJson(e))
                .toList();

  // 言語番号から言語コードを取得
  String langCodeOfMeaning() {
    return languageCodeMap.entries
        .firstWhere((entry) => entry.value == langNumberOfMeaning)
        .key;
  }

  // 却下されたwordRequestのリクエストの数
  int rejectedWordRequestsCount() =>
      wordRequestsCount - acceptedWordRequestsCount - pendingWordRequestsCount;
  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'sentence_id': sentenceId,
        'pos_tag_id': posTagId,
        'entry': entry,
        'lang_number_of_entry': langNumberOfEntry,
        'entry_ssml': entrySsml,
        'entry_audio_url': entryAudioUrl,
        'meaning': meaning,
        'meaning_ja': meaningJa,
        'meaning_en': meaningEn,
        'lang_number_of_meaning': langNumberOfMeaning,
        'explanation': explanation,
        'meaning_image_url': meaningImageUrl,
        'pos': pos,
        'ipa': ipa,
        'reading': reading,
        'etymologies': etymologies,
        'synonyms': synonyms,
        'antonyms': antonyms,
        'related': related,
        'senses_json': sensesJson,
        'senses_tags': sensesTags,
        'forms_list': formsList,
        'word_requests_count': wordRequestsCount,
        'accepted_word_requests_count': acceptedWordRequestsCount,
        'pending_word_requests_count': pendingWordRequestsCount,
        'sentence': sentence,
        'dictionary': dictionary,
        'pos_tag': posTag,
        'quiz': quiz,
        'reversed_quiz': reversedQuiz,
        'senses': senses,
        'grammatical_tags': grammaticalTags,
      };
}
