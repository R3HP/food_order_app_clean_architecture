import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/accounting/domain/entity/account.dart';
import 'package:food_order_app/features/orders/domain/entity/order.dart';

abstract class OrderRepository {

  Future<Either<ServerFailure,List<OrderModel>>> getUserOrders();

  Future<Either<ServerFailure,void>> addOrder(OrderModel newOrder);

  Future<Either<ServerFailure,void>> updateOrder(OrderModel newOrder);
}