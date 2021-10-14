class User {
  User({
    this.id,
    this.name = '',
    this.icon = '',
    this.profile = '',
  });

  int? id;
  String? name;
  String? icon;
  String? profile;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        icon = json['icon'],
        profile = json['profile'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'icon': icon, 'profile': profile};
}
