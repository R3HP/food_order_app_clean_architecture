import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/cart/domain/entity/cart.dart';
import 'package:food_order_app/features/cart/domain/repository/cart_repository.dart';

class AddCartItemToCartListUseCase {
  final CartRepository cartRepository;

  AddCartItemToCartListUseCase({
    required this.cartRepository,
  });

  Future<Either<ServerFailure, void>> call(CartItem cartItem) async {
    final response = await cartRepository.addCartItemToCartList(cartItem);
    return response ; 
  }
}
