import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/orders/domain/entity/order.dart';
import 'package:food_order_app/features/orders/domain/repository/order_repository.dart';

class UpdateOrderUseCase {
  final OrderRepository orderRepository;

  UpdateOrderUseCase({
    required this.orderRepository,
  });

  Future<Either<ServerFailure,void>> call(OrderModel newOrder) async {
    final response = await orderRepository.updateOrder(newOrder);
    return response;
  }
}
