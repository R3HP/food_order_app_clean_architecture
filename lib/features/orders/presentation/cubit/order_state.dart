part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoadingState extends OrderState{}

class AddNewOrderFailedState extends OrderState{
  final String message;

  const AddNewOrderFailedState(this.message);

  @override
  List<Object> get props => [message];
}

class AddNewOrderSuccessState extends OrderState{
  final String message;

  const AddNewOrderSuccessState(this.message);

  @override
  List<Object> get props => [message];
}

class GetUserOrdersSuccessState extends OrderState {
  final List<OrderModel> orders;
  
  const GetUserOrdersSuccessState({
    required this.orders,
  });

  @override
  List<Object> get props => [orders];
}

class GetUserOrdersFailState extends OrderState {
  final String message;
  
  const GetUserOrdersFailState({
    required this.message
  });

  @override
  List<Object> get props => [message];
}

class UpdateOrderSuccessState extends OrderState {
  final String message;
  
  const UpdateOrderSuccessState({
    required this.message
  });

  @override
  List<Object> get props => [message];
}


class UpdateOrderFailState extends OrderState {
  final String message;
  
  const UpdateOrderFailState({
    required this.message
  });

  @override
  List<Object> get props => [message];
}