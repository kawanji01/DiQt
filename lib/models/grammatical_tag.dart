class GrammaticalTag {
  GrammaticalTag({
    required this.id,
    required this.grammaticalTagMapsCount,
    required this.name,
    this.universalName,
    required this.createdAt,
    required this.updatedAt,
    required this.dictionaryId,
  });

  int id;
  int grammaticalTagMapsCount;
  String name;
  String? universalName;
  DateTime createdAt;
  DateTime updatedAt;
  int dictionaryId;

  GrammaticalTag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        grammaticalTagMapsCount = json['grammatical_tag_maps_count'],
        name = json['name'],
        universalName = json['universal_name'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        dictionaryId = json['dictionary_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'grammatical_tag_maps_count': grammaticalTagMapsCount,
        'name': name,
        'universal_name': universalName,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'dictionary_id': dictionaryId,
      };
}
