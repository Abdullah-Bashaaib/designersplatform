class UserEntity {
  final String id;
  final String name;
  final String email;
  final String role;
  late String? avatarUrl;
  final List<String> keywords;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl,
    required this.keywords,
  });

  UserEntity copyWith(
      {String? id,
      String? name,
      String? email,
      String? role,
      String? avatarUrl,
      List<String>? keywords}) {
    return UserEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        keywords: keywords ?? this.keywords);
  }
}
