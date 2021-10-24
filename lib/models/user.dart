class User {
  User({
    this.id,
    this.publicUid,
    this.name = '',
    this.icon = '',
    this.profile = '',
  });

  int? id;
  String? publicUid;
  String? name;
  String? icon;
  String? profile;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        publicUid = json['public_uid'],
        name = json['name'],
        icon = json['icon'],
        profile = json['profile'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'public_uid': publicUid,
        'name': name,
        'icon': icon,
        'profile': profile
      };
}
