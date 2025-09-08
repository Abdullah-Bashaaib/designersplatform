class Work {
  final String id;
  final String designerId;
  final String imageUrl;
  final String description;
  final DateTime createdAt;
  final int likesCount;

  Work({
    required this.id,
    required this.designerId,
    required this.imageUrl,
    required this.description,
    required this.createdAt,
    required this.likesCount,
  });
}
