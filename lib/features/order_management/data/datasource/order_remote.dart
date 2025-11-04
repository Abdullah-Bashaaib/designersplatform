import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/order_management/data/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderRemote {
  Future<void> addOrder(OrderModel orderModel);
  Future<List<OrderModel>> getOrders(String column);
  Future<void> deleteOrder(String orderId);
  Future<void> updateOrder(String orderId, Map<String, dynamic> fields);
}

class OrderRemoteImp implements OrderRemote {
  final FirebaseFirestore firestore;
  final SharedPreferences sharedPreferences;

  OrderRemoteImp(
    this.firestore,
    this.sharedPreferences,
  );

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
  Future<List<OrderModel>> getOrders(String column) async {
    // final userList = sharedPreferences.getString(KeySharedPref.userKey);
    // final userJson = jsonDecode(userList!);

    try {
      log("--------> message: there is in get order firebase ID is ${CurrentUser.currentUser!.id}");
      final query = await firestore
          .collection('Orders')
          .where(column, isEqualTo: CurrentUser.currentUser!.id)
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

  @override
  Future<void> updateOrder(String orderId, Map<String, dynamic> fields) async {
    try {
      await firestore.collection('Orders').doc(orderId).update(fields);
    } catch (e) {
      throw ServerException(e);
    }
  }
}
