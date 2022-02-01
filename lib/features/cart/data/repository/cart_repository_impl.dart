import 'package:food_order_app/core/error/exception.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:food_order_app/features/cart/data/dataSource/cart_data_source.dart';
import 'package:food_order_app/features/cart/domain/entity/cart.dart';
import 'package:food_order_app/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource dataSource;

  CartRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<ServerFailure, void>> addCartItemToCartList(
      CartItem cartItem) async {
    try {
      final response = await dataSource.addCartItemToCart(cartItem);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> clearCart() async {
    try {
      final response = await dataSource.clearCart();

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> deleteCartItemFromCartList(
      int cartItemId) async {
    try {
      final response = await dataSource.deleteCartItemFromCart(cartItemId);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<CartItem>>> getCartList() async {
    try {
      final response = await dataSource.getCartItems();

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    } catch (error) {
      print('repositoryImpl : $error');
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> updateItemQuantity(int newQuantity, int cartItemId,double lastTotalPrice) async {
    try{
      final response = await  dataSource.updateCartItemQuantity(newQuantity, cartItemId,lastTotalPrice);
      return Right(response);
    }on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch(error){
      return Left(ServerFailure(message: 'Unecpected Exception'));
    }
  }
}
