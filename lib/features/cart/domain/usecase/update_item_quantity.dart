import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/cart/domain/repository/cart_repository.dart';

class UpdateItemQuantityUseCase {
  final CartRepository cartRepository;

  UpdateItemQuantityUseCase({
    required this.cartRepository,
  });

  Future<Either<ServerFailure,void>> call(int newQuantity, int cartItemId,double lastTotalPrice) async {
    final response = await cartRepository.updateItemQuantity(newQuantity, cartItemId,lastTotalPrice);
    
    return response;
  }
}
