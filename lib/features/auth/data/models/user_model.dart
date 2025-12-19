import 'package:designers_platform/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.role,
    super.avatarUrl,
    required super.keywords,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      role: json['role'],
      avatarUrl: json['avatarUrl'],
      keywords: List<String>.from(json["keywords"] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'role': role,
      'avatarUrl': avatarUrl,
      "keywords": keywords,
    };
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phoneNumber: user.phoneNumber,
      role: user.role,
      avatarUrl: user.avatarUrl,
      keywords: List<String>.from(user.keywords ?? []),
    );
  }
}
