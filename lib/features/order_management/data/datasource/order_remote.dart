import 'dart:developer';

import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/order_management/data/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderRemote {
  Future<void> addOrder(OrderModel orderModel);
  Future<List<OrderModel>> getOrders(String column);
  Future<void> deleteOrder(String orderId);
  Future<void> updateOrder(String orderId, Map<String, dynamic> fields);
}

class OrderRemoteImp implements OrderRemote {
  final SharedPreferences sharedPreferences;
  final SupabaseClient supabase;

  OrderRemoteImp(
    this.sharedPreferences,
    this.supabase,
  );

  @override
  Future<void> addOrder(OrderModel orderModel) async {
    try {
      await supabase.from('orders').insert([orderModel.toMap()]);
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
      final response = await supabase
          .from('orders')
          .select()
          .eq(column, CurrentUser.currentUser!.id);

      return response.map((m) => OrderModel.fromJson(m)).toList();
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    try {
      await supabase.from('orders').delete().eq('id', orderId);
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<void> updateOrder(String orderId, Map<String, dynamic> fields) async {
    try {
      await supabase.from('orders').update(fields).eq('id', orderId);
    } catch (e) {
      throw ServerException(e);
    }
  }
}
