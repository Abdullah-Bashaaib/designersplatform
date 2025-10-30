import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/order_management/data/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/key_app.dart';

abstract class OrderRemote {
  Future<void> addOrder(OrderModel orderModel);
  Future<List<OrderModel>> getOrders(String colum);
}

class OrderRemoteImp implements OrderRemote {
  final FirebaseFirestore firestore;
  final SharedPreferences sharedPreferences;

  OrderRemoteImp(this.firestore, this.sharedPreferences);

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
    final user = jsonDecode(userList!);
    log("--------> message: there is in get order firebase ID is ${user['id']}");

    try {
      final query = await firestore
          .collection('Orders')
          .where(colum, isEqualTo: user['id'])
          .get();

      return query.docs.map((m) => OrderModel.fromJson(m.data())).toList();
    } catch (e) {
      throw ServerException(e);
    }
  }
}
