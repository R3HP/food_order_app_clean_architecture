import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/cart/domain/repository/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository cartRepository;

  ClearCartUseCase({
    required this.cartRepository,
  });

  Future<Either<ServerFailure, void>> call() async {
    final response = await cartRepository.clearCart();
    return response;
  }
}
