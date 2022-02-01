import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/exception.dart';

import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/accounting/domain/entity/account.dart';
import 'package:food_order_app/features/orders/data/dataSource/order_data_source.dart';
import 'package:food_order_app/features/orders/domain/entity/order.dart';
import 'package:food_order_app/features/orders/domain/repository/order_repository.dart';

class OrderRepositoryIMpl implements OrderRepository {
  final OrderDataSource orderDataSource;

  OrderRepositoryIMpl({
    required this.orderDataSource,
  });


  @override
  Future<Either<ServerFailure, void>> addOrder(OrderModel newOrder) async {
    try{
      final response = await orderDataSource.addOrder(newOrder);
      return Right(response);
    }on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch(error){
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<OrderModel>>> getUserOrders() async {
    try{
      final response = await orderDataSource.getUsersOrdersData();
      return Right(response);
    }on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch(error){
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> updateOrder(OrderModel newOrder) async {
    try{
      final response = await orderDataSource.updateOrder(newOrder);
      return Right(response);
    }on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch(error){
      return Left(ServerFailure(message: error.toString()));
    }
  }

}
