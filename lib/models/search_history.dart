import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/user.dart';

class SearchHistory {
  SearchHistory({
    required this.id,
    this.deviceType,
    this.keywords,
    this.dailyReportId,
    required this.dictionaryId,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String? deviceType;
  String? keywords;
  int? dailyReportId;
  int dictionaryId;
  int? userId;
  Dictionary? dictionary;
  User? user;
  DateTime createdAt;
  DateTime updatedAt;

  SearchHistory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        deviceType = json['device_type'],
        keywords = json['keywords'],
        dailyReportId = json['daily_report_id'],
        dictionaryId = json['dictionary_id'],
        userId = json['user_id'],
        dictionary = json['dictionary'] != null
            ? Dictionary.fromJson(json['dictionary'])
            : null,
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'device_type': deviceType,
        'keywords': keywords,
        'daily_report_id': dailyReportId,
        'dictionary_id': dictionaryId,
        'user_id': userId,
        'dictionary': dictionary?.toJson(),
        'user': user?.toJson(),
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
