class User {
  final String id;
  final String name;
  final String email;
  final String role;
  late String? avatarUrl;
  final List<String> keywords;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl,
    required this.keywords,
  });

  User copyWith(
      {String? id,
      String? name,
      String? email,
      String? role,
      String? avatarUrl,
      List<String>? keywords}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        keywords: keywords ?? this.keywords);
  }
}
