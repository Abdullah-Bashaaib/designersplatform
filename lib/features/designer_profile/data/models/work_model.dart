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
      designerId: json['designer_id'],
      imageUrl: json['image_url'],
      description: json['description'],
      createdAt: json['created_at'],
      likesCount: json['likes_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'designer_id': designerId,
      'image_url': imageUrl,
      'description': description,
      'created_at': createdAt,
      'likes_count': likesCount,
    };
  }
}
