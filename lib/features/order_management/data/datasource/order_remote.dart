import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/order_management/data/models/order_model.dart';

abstract class OrderRemote {
  Future<void> addOrder(OrderModel orderModel);
  Future<List<OrderModel>> getOrders();
  Future<void> deleteOrder(String orderId);
}

class OrderRemoteImp implements OrderRemote {
  final FirebaseFirestore firestore;

  OrderRemoteImp(this.firestore);

  @override
  Future<void> addOrder(OrderModel orderModel) async {
    try {
      await firestore
          .collection('Orders')
          .doc(orderModel.id)
          .set(orderModel.toMap());
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final query = await firestore
          .collection('Orders')
          .where('clientId', isEqualTo: CurrentUser.currentUser!.id)
          .get();

      return query.docs.map((m) => OrderModel.fromJson(m.data())).toList();
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    try {
      await firestore.collection('Orders').doc(orderId).delete();
    } catch (e) {
      throw ServerException(e);
    }
  }
}
