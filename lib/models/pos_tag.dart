import 'package:booqs_mobile/models/dictionary.dart';

class PosTag {
  PosTag({
    required this.id,
    required this.dictionaryId,
    required this.name,
    required this.universalName,
    required this.enName,
    required this.explanation,
    required this.orderNumber,
    required this.createdAt,
    required this.updatedAt,
    this.dictionary,
  });

  int id;
  int dictionaryId;
  String name;
  String? universalName;
  String? enName;
  String? explanation;
  int orderNumber;
  DateTime createdAt;
  DateTime updatedAt;
  Dictionary? dictionary;

  PosTag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        name = json['name'],
        universalName = json['universal_name'],
        enName = json['en_name'],
        explanation = json['explanation'],
        orderNumber = json['order_number'] ?? 0,
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['dictionary']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'name': name,
        'universal_name': universalName,
        'en_name': enName,
        'explanation': explanation,
        'order_number': orderNumber,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'dictionary': dictionary,
      };
}
