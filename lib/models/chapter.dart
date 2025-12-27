import 'package:booqs_mobile/models/custom_section.dart';
import 'package:booqs_mobile/models/school.dart';

class Chapter {
  Chapter(
      {required this.id,
      required this.appliedDictionaryId,
      required this.title,
      required this.langNumberOfTitle,
      required this.introduction,
      required this.thumbnailUrl,
      required this.publicUid,
      required this.schoolId,
      this.referenceUrl,
      this.referenceTitle,
      this.referenceOgp,
      required this.drillsCount,
      required this.customSectionsCount,
      required this.createdAt,
      required this.updatedAt,
      // eager_loadでキャッシュしたdrillの情報
      this.answerHistoriesCount,
      this.school,
      this.customSections});

  int id;
  int? appliedDictionaryId;
  String title;
  int langNumberOfTitle;
  String introduction;
  String thumbnailUrl;
  String publicUid;
  int? schoolId;
  String? referenceUrl;
  String? referenceTitle;
  String? referenceOgp;
  int drillsCount;
  int customSectionsCount;
  DateTime createdAt;
  DateTime updatedAt;
  // テーブルを結合してキャッシュしたdrillの情報
  int? answerHistoriesCount;
  School? school;
  List<CustomSection>? customSections;

  Chapter.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        appliedDictionaryId = json['applied_dictionary_id'],
        title = json['title'] ?? '',
        langNumberOfTitle = json['langNumberOfTitle'] ?? 44,
        introduction = json['introduction'] ?? '',
        thumbnailUrl = json['thumbnail_url'] ?? '',
        publicUid = json['public_uid'],
        schoolId = json['school_id'],
        referenceUrl = json['reference_url'],
        referenceTitle = json['reference_title'],
        referenceOgp = json['reference_ogp'],
        drillsCount = json['drills_count'] ?? 0,
        customSectionsCount = json['custom_sections_count'] ?? 0,
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        // テーブルを結合してキャッシュしたdrillの情報,
        answerHistoriesCount = json['answer_histories_count'] ?? 0,
        school =
            json['school'] != null ? School.fromJson(json['school']) : null,
        customSections = json['custom_sections'] == null
            ? []
            : json['custom_sections']
                .map<CustomSection>((e) => CustomSection.fromJson(e))
                .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'applied_dictionary_id': appliedDictionaryId,
        'name': title,
        'introduction': introduction,
        'thumbnail_url': thumbnailUrl,
        'public_uid': publicUid,
        'school_id': schoolId,
        'reference_url': referenceUrl,
        'reference_title': referenceTitle,
        'reference_ogp': referenceOgp,
        'drills_count': drillsCount,
        'custom_sections_count': customSectionsCount,
        'created_at': createdAt,
        'updated_at': updatedAt,
        // テーブルを結合してキャッシュしたdrillの情報,
        'answer_histories_count': answerHistoriesCount,
        'school': school?.toJson(),
      };
}
