part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}


class CartLoading extends CartState{}

class CartLoadedSuccessState extends CartState{
  final List<CartItem> cartitems;

  const CartLoadedSuccessState({
    required this.cartitems,
  });

  @override
  List<Object> get props => cartitems;
}

class CartLoadingFailedState extends CartState {
  final String message;

  const CartLoadingFailedState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class CartAddItemSuccesState extends CartState {
  final String message;

  const CartAddItemSuccesState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class CartAddItemFailState extends CartState {
  final String message;

  const CartAddItemFailState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class CartClearListSuccessState extends CartState {
  final String message;

  const CartClearListSuccessState({
    required this.message,
  });
}

class CartClearListFailState extends CartState {
  final String message;

  const CartClearListFailState({
    required this.message,
  });
}

class CartDeleteCartItemSuccessState extends CartState {
  final String message;

  const CartDeleteCartItemSuccessState({
    required this.message,
  });
}

class CartDeleteCartItemFailState extends CartState {
  final String message;

  const CartDeleteCartItemFailState({
    required this.message,
  });
}

