import 'package:dartz/dartz.dart';

import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/orders/domain/entity/order.dart';
import 'package:food_order_app/features/orders/domain/repository/order_repository.dart';

class AddNewOrderUseCase {
  
  final OrderRepository orderRepository;
  AddNewOrderUseCase({
    required this.orderRepository,
  });

  Future<Either<ServerFailure,void>> call(OrderModel newOrder) async {
    /// SHOULD WE ADD ORDER TO USERS TABLE HERE TO?? IF NOT FUNCTION 
    /// SHOULD RETURN A STRING WHICH IS ORDER ID TO ADD IN USERS TABLE
    final response = await orderRepository.addOrder(newOrder);
    return response;
  }
}
