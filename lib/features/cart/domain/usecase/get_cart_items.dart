import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/cart/domain/entity/cart.dart';
import 'package:food_order_app/features/cart/domain/repository/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository cartRepository;
  
  GetCartItemsUseCase({
    required this.cartRepository,
  });
  

  Future<Either<ServerFailure, List<CartItem>>> call() async {
      final response = await cartRepository.getCartList();
      return response;
    
  }
}
