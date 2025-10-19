import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/order_management/data/models/order_model.dart';

abstract class OrderRemote {
  Future<void> addOrder(OrderModel orderModel);
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
}
