import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/order_management/data/models/order_model.dart';
import 'package:designers_platform/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupervisorRemoteDataSource {
  Future<List<OrderModel>> getPendingOrders();
  Future<void> approveOrder(String orderId);
  Future<void> updateSupervisorProfile(
      String userId, Map<String, dynamic> data);
}

class SupervisorRemoteDataSourceImpl implements SupervisorRemoteDataSource {
  final SupabaseClient supabase;

  SupervisorRemoteDataSourceImpl(this.supabase);

  @override
  Future<List<OrderModel>> getPendingOrders() async {
    try {
      // Query orders where adminApproval is false or null (if applicable, but likely false based on requirement)
      // The requirement says "adminApproval false".
      // Assuming 'adminApproval' is the column name in 'orders' table.
      // Based on OrderModel, it expects String? adminApproval

      final response = await supabase.from('orders').select().eq(
          'adminApproval',
          'false'); // Assuming string 'false' based on previous context

      return (response as List).map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> approveOrder(String orderId) async {
    try {
      await supabase
          .from('orders')
          .update({'adminApproval': 'true'}).eq('id', orderId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateSupervisorProfile(
      String userId, Map<String, dynamic> data) async {
    try {
      await supabase.from('users').update(data).eq('id', userId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
