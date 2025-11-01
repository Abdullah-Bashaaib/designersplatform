import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/utils/key_app.dart';
import 'package:designers_platform/features/order_management/data/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderRemote {
  Future<void> addOrder(OrderModel orderModel);
  Future<List<OrderModel>> getOrders(String colum);
  Future<void> deleteOrder(String orderId);
  Future<void> updateOrder(String orderId, String type, String description);
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
  Future<List<OrderModel>> getOrders(String colum) async {
    final userList = sharedPreferences.getString(KeySharedPref.userKey);
    final userJson = jsonDecode(userList!);
    log("--------> message: there is in get order firebase ID is ${userJson['role']}");

    try {
      log("--------> message: there is in get order firebase ID is ${userJson['id']}");
      log("---------> message: Colum is $colum , name: ${userJson['name']}, ID: ${userJson['id']}");
      final query = await firestore
          .collection('Orders')
          .where(colum, isEqualTo: userJson['id'])
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
  Future<void> updateOrder(
      String orderId, String type, String description) async {
    try {
      await firestore
          .collection('Orders')
          .doc(orderId)
          .update({'designType': type, 'description': description});
    } catch (e) {
      throw ServerException(e);
    }
  }
}
