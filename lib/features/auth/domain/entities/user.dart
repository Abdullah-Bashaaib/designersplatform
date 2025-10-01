class User {
  final String id;
  String name;
  final String email;
  final String role;
  final String? avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl,
  });
}
