import 'package:booqs_mobile/models/drill.dart';

class CustomSection {
  int id;
  int chapterId;
  String title;
  String? introduction;
  int orderNumber;
  int amountToDisplay;
  int customSectionMapsCount;
  DateTime createdAt;
  DateTime updatedAt;
  List<Drill>? drills;

  CustomSection(
      {required this.id,
      required this.chapterId,
      required this.title,
      this.introduction,
      required this.orderNumber,
      required this.amountToDisplay,
      required this.customSectionMapsCount,
      required this.createdAt,
      required this.updatedAt,
      this.drills});

  CustomSection.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        chapterId = json['chapter_id'],
        title = json['title'],
        introduction = json['introduction'],
        orderNumber = json['order_number'],
        amountToDisplay = json['amount_to_display'],
        customSectionMapsCount = json['custom_section_maps_count'] ?? 0,
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        drills = json['drills'] == null
            ? []
            : List<Drill>.from(json['drills'].map((e) => Drill.fromJson(e)));

  Map<String, dynamic> toJson() => {
        'id': id,
        'chapter_id': chapterId,
        'title': title,
        'introduction': introduction,
        'order_number': orderNumber,
        'amount_to_display': amountToDisplay,
        'custom_section_maps_count': customSectionMapsCount,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String()
      };
}
