// DBではNotificationであるが、FlutterにはNotificationがすでに独立のクラスとして存在したり、外部ライブラリにも同名のクラスが存在したりと問題が起きやすいので、
// NotificationからNoticeに変更した。
import 'package:booqs_mobile/models/achievement.dart';
import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/cheer.dart';
import 'package:booqs_mobile/models/monthly_report.dart';
import 'package:booqs_mobile/models/relationship.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/weekly_report.dart';
import 'package:booqs_mobile/models/word_request.dart';

class Notice {
  Notice({
    required this.id,
    required this.notifyingId,
    required this.notifiedId,
    this.activityId,
    this.cheerId,
    this.monthlyReportId,
    this.weeklyReportId,
    this.inquiryId,
    this.achievementId,
    this.wordRequestId,
    this.sentenceRequestId,
    this.quizRequestId,
    this.information,
    required this.read,
    required this.notifiedType,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.notifying,
    this.notified,
    this.weeklyReport,
    this.monthlyReport,
    this.achievement,
    this.activity,
    this.cheer,
    this.relationship,
    this.wordRequest,
  });

  int id;
  int? notifyingId;
  int notifiedId;
  int? activityId;
  int? cheerId;
  int? monthlyReportId;
  int? weeklyReportId;
  int? inquiryId;
  int? achievementId;
  int? wordRequestId;
  int? sentenceRequestId;
  int? quizRequestId;
  String? information;
  bool read;
  String? imageUrl;
  String notifiedType;
  DateTime createdAt;
  DateTime updatedAt;
  User? notifying;
  User? notified;
  WeeklyReport? weeklyReport;
  MonthlyReport? monthlyReport;
  Achievement? achievement;
  Activity? activity;
  Cheer? cheer;
  Relationship? relationship;
  WordRequest? wordRequest;

  Notice.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        notifyingId = json['notifying_id'],
        notifiedId = json['notified_id'],
        activityId = json['activity_id'],
        cheerId = json['cheer_id'],
        monthlyReportId = json['monthly_report_id'],
        weeklyReportId = json['weekly_report_id'],
        inquiryId = json['inquiry_id'],
        achievementId = json['achievement_id'],
        wordRequestId = json['word_request_id'],
        sentenceRequestId = json['sentence_request_id'],
        quizRequestId = json['quiz_request_id'],
        information = json['information'],
        read = json['read'],
        imageUrl = json['image_url'],
        notifiedType = json['notified_type'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        notifying =
            json['notifying'] == null ? null : User.fromJson(json['notifying']),
        notified =
            json['notified'] == null ? null : User.fromJson(json['notified']),
        weeklyReport = json['weekly_report'] == null
            ? null
            : WeeklyReport.fromJson(json['weekly_report']),
        monthlyReport = json['monthly_report'] == null
            ? null
            : MonthlyReport.fromJson(json['monthly_report']),
        achievement = json['achievement'] == null
            ? null
            : Achievement.fromJson(json['achievement']),
        activity = json['activity'] == null
            ? null
            : Activity.fromJson(json['activity']),
        cheer = json['cheer'] == null ? null : Cheer.fromJson(json['cheer']),
        relationship = json['relationship'] == null
            ? null
            : Relationship.fromJson(json['relationship']),
        wordRequest = json['word_request'] == null
            ? null
            : WordRequest.fromJson(json['word_request']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'notifying_id': notifyingId,
        'notified_id': notifiedId,
        'activity_id': activityId,
        'cheer_id': cheerId,
        'monthly_report_id': monthlyReportId,
        'weekly_report_id': weeklyReportId,
        'inquiry_id': inquiryId,
        'achievement_id': achievementId,
        'word_request_id': wordRequestId,
        'sentence_request_id': sentenceRequestId,
        'quiz_request_id': quizRequestId,
        'information': information,
        'read': read,
        'imageUrl': imageUrl,
        'notified_type': notifiedType,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'notifying': notifying,
        'notified': notified,
        'weekly_report': weeklyReport,
        'monthly_report': monthlyReport,
        'achievement': achievement,
        'activity': activity,
        'cheer': cheer,
        'relationship': relationship,
        'word_request': wordRequest,
      };
}
