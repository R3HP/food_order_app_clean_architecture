import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:food_order_app/core/error/exception.dart';
import 'package:food_order_app/features/orders/domain/entity/order.dart';

class OrderDataSource {
  final Supabase supabase;
  // final Account account;

  OrderDataSource({
    required this.supabase,
    // required this.account,
  });

  Future<List<OrderModel>> getUsersOrdersData() async {
    try {
      final response = await supabase.client
          .from('orders')
          .select('*')
          .eq('user_id', supabase.client.auth.currentUser!.id)
          .execute();
      if (response.error != null) {
        throw ServerException(response.error!.message);
      }
      final responseData = response.data as List<dynamic>;
      final userOrdersList =
          responseData.map((e) => OrderModel.fromMap(e)).toList();
      return userOrdersList;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  Future<void> addOrder(OrderModel newOrder) async {
    try {
      final response = await supabase.client
          .from('orders')
          .insert(newOrder.toMap())
          .execute();
      if (response.error != null) {
        throw ServerException(response.error!.message);
      }
      return;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  Future<void> updateOrder(OrderModel newOrder) async {
    try {
      final response = await supabase.client
          .from('orders')
          .update(newOrder.toMap())
          .eq('id', newOrder.id)
          .execute();
      if (response.error != null) {
        throw ServerException(response.error!.message);
      }
      return;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}
