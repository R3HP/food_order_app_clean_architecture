import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/cart/domain/repository/cart_repository.dart';

class DeleteCartItemFromCartListUseCase {
  final CartRepository cartRepository;

  DeleteCartItemFromCartListUseCase({
    required this.cartRepository,
  });

  Future<Either<ServerFailure, void>> call(int cartItemId) async {
    final response = await  cartRepository.deleteCartItemFromCartList(cartItemId);
    return response;
  }
}
