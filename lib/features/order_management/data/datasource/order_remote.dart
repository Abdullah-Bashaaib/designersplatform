import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/order_management/data/models/order_model.dart';

abstract class OrderRemote {
  Future<void> addOrder(OrderModel orderModel);
  Future<List<OrderModel>> getOrders(String colum);
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
    log("--------> message: there is in get order firebase ID is ${CurrentUser.currentUser?.role}");

    try {
      log("--------> message: there is in get order firebase ID is ${CurrentUser.currentUser!.id}");
      final query = await firestore
          .collection('Orders')
          .where('clientId', isEqualTo: CurrentUser.currentUser!.id)
          .get();

      return query.docs.map((m) => OrderModel.fromJson(m.data())).toList();
    } catch (e) {
      throw ServerException(e);
    }
  }
}
