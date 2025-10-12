import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';

class Client {
  final String userId;
  List<User>? favorites;
  List<OrderEntity>? orders;

  Client({ required this.userId, this.favorites, this.orders});
}
