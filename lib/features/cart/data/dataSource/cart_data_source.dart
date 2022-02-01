import 'package:food_order_app/core/error/exception.dart';
import 'package:food_order_app/features/cart/domain/entity/cart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CartDataSource {
  Future<List<CartItem>> getCartItems();
  Future<void> clearCart();
  Future<void> addCartItemToCart(CartItem cartItem);
  Future<void> deleteCartItemFromCart(int cartItemId);
  Future<void> updateCartItemQuantity(int newQuantity, int cartItemId,double lastTotalPrice);
}

class CartDataSourceImpl implements CartDataSource {
  @override
  Future<void> addCartItemToCart(CartItem cartItem) async {
    try {
      final cartMap = cartItem.toMap();
      // final map = {'user_id': '9fc049b9-f2f5-4b1c-a8e0-f5811ab319f0', 'product_id': 12, 'price_per_one': 32.0, 'total_price': 32.0, 'quantity': 1, 'product_name': 'Mom\'s Spaghetti'};
      print(cartMap);
      final response = await Supabase.instance.client
          .from('carts')
          .insert(cartMap)
          .execute();
      print(response.data);
      if (response.error != null) {
        print('dataSourceAddError : ${response.error}');

        throw ServerException(response.error!.message);
      }
    } catch (error) {
      print('dataSourceAdd : ${error}');
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      final response = await Supabase.instance.client
          .from('carts')
          .delete()
          .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
          .execute();
      if (response.error != null) {
        throw ServerException(response.error!.message);
      }
      return;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> deleteCartItemFromCart(int cartItemId) async {
    try {
      final response = await Supabase.instance.client
          .from('carts')
          .delete()
          .eq('id', cartItemId)
          .execute();
      if (response.error != null) {
        throw ServerException(response.error!.message);
      }
      return;
    } catch (error) {
      print('dataSpurceDelete : $error');
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    try {
      print(Supabase.instance.client.auth.currentUser!.id);
      final response = await Supabase.instance.client
          .from('carts')
          .select('*')
          .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
          .execute();
      if (response.error != null) {
        print('dataSourceGet Error : ${response.error}');
        throw ServerException(response.error!.message);
      }
      final responseData = response.data as List<dynamic>;
      print(response.data);
      final cartList =
          responseData.map((cartData) => CartItem.fromMap(cartData)).toList();
      return cartList;
    } catch (error) {
      print('dataSourceGet : ${error}');
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> updateCartItemQuantity(int newQuantity, int cartItemId,double lastTotalPrice) async {
    try {
      final updateMap = {'quantity': newQuantity,'total_price' : newQuantity * lastTotalPrice};
      final response = await Supabase.instance.client
          .from('carts')
          .update(updateMap)
          .eq('id', cartItemId)
          .execute();
      if (response.error != null) {
        throw ServerException(response.error!.message);
      }
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}
