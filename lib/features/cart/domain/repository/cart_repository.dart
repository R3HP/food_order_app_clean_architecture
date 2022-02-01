import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/cart/domain/entity/cart.dart';

abstract class CartRepository {
  Future<Either<ServerFailure, List<CartItem>>> getCartList();
  Future<Either<ServerFailure,void>> addCartItemToCartList(CartItem cartItem);
  Future<Either<ServerFailure,void>> deleteCartItemFromCartList(int cartItemId);
  Future<Either<ServerFailure,void>> clearCart();
  Future<Either<ServerFailure,void>> updateItemQuantity(int newQuantity,int cartItemId,double lastTotalPrice);
}
