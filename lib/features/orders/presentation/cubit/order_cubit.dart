import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:food_order_app/features/orders/domain/entity/order.dart';
import 'package:food_order_app/features/orders/domain/usecase/add_new_order_usecase.dart';
import 'package:food_order_app/features/orders/domain/usecase/get_user_orders_data_usecase.dart';
import 'package:food_order_app/features/orders/domain/usecase/update_order.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final AddNewOrderUseCase addNewOrderUseCase;
  final GetUserOrdersUseCase getUserOrdersUseCase;
  final UpdateOrderUseCase updateOrdersUseCase;

  OrderCubit(
    this.addNewOrderUseCase,
    this.getUserOrdersUseCase,
    this.updateOrdersUseCase,
  ) : super(OrderInitial());

  addNewOrder(OrderModel orderModel) async {
    emit(OrderLoadingState());

    final response = await addNewOrderUseCase(orderModel);

    response.fold(
        (fail) => emit(AddNewOrderFailedState(fail.message)),
        (success) =>
            emit(const AddNewOrderSuccessState('Your Order Has Been Placed')));
  }

  getUserOrders() async {
    emit(OrderLoadingState());

    final response = await getUserOrdersUseCase();

    response.fold((fail) => emit(GetUserOrdersFailState(message: fail.message)),
        (success) => emit(GetUserOrdersSuccessState(orders: success)));
  }

  updateOrder(OrderModel newModel) async {
    emit(OrderLoadingState());

    final response = await updateOrdersUseCase(newModel);

    response.fold(
        (fail) => emit(UpdateOrderFailState(message: fail.message)),
        (success) => emit(
            const UpdateOrderSuccessState(message: 'Order Has Been Updated')));
  }
}
