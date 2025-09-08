// what designer field need?
class DesignerEntity {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String role;
  final double rating;
  final int totalOrders;
  final String specialization;
  final bool isAvailable;

  DesignerEntity({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.rating,
    required this.totalOrders,
    required this.specialization,
    required this.isAvailable,
  });
}
