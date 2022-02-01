import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/accounting/domain/entity/account.dart';
import 'package:food_order_app/features/orders/domain/entity/order.dart';
import 'package:food_order_app/features/orders/domain/repository/order_repository.dart';

class GetUserOrdersUseCase {
  final OrderRepository orderRepository;

  GetUserOrdersUseCase({
    required this.orderRepository,
  });

  Future<Either<ServerFailure,List<OrderModel>>> call()async{
    final response = await orderRepository.getUserOrders();
    return response;
  }
  
}
