import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';

class WorkModel extends Work {
  WorkModel(
      {required super.id,
      required super.designerId,
      required super.imageUrl,
      required super.description,
      required super.createdAt,
      required super.likesCount});

  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      id: json['id'],
      designerId: json['designerId'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      createdAt: json['createdAt'],
      likesCount: json['likesCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'designerId': designerId,
      'imageUrl': imageUrl,
      'description': description,
      'createdAt': createdAt,
      'likesCount': likesCount,
    };
  }
}
