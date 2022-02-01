import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:food_order_app/features/cart/domain/entity/cart.dart';
import 'package:food_order_app/features/cart/domain/usecase/add_cart_item_cart_list.dart';
import 'package:food_order_app/features/cart/domain/usecase/clear_cart.dart';
import 'package:food_order_app/features/cart/domain/usecase/delete_cart_item_from_cart_list.dart';
import 'package:food_order_app/features/cart/domain/usecase/get_cart_items.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddCartItemToCartListUseCase addCartItemToCartListUseCase;
  final ClearCartUseCase clearCartUseCase;
  final GetCartItemsUseCase getCartItemsUseCase;
  final DeleteCartItemFromCartListUseCase deleteCartItemFromCartListUseCase;

  CartCubit(
    this.addCartItemToCartListUseCase,
    this.clearCartUseCase,
    this.getCartItemsUseCase,
    this.deleteCartItemFromCartListUseCase,
  ) : super(CartInitial());

  addCartItemToList(CartItem cartItem) async {
    emit(CartLoading());
    final response = await addCartItemToCartListUseCase(cartItem);

    response.fold(
        (l) => emit(CartAddItemFailState(message: l.message)),
        (r) => emit(
            const CartAddItemSuccesState(message: 'Item Added Succesfully')));
  }

  deleteCartItemFromList(int cartItemId) async {
    emit(CartLoading());
    final response = await deleteCartItemFromCartListUseCase(cartItemId);

    response.fold(
        (l) => emit(CartDeleteCartItemFailState(message: l.message)),
        (r) => emit(const CartDeleteCartItemSuccessState(
            message: 'Item Added Succesfully')));
  }

  clearCartList() async {
    emit(CartLoading());

    final response = await clearCartUseCase();

    response.fold(
        (failure) => emit(CartClearListFailState(message: failure.message)),
        (success) => emit(
            const CartClearListSuccessState(message: 'Cart List Cleared')));
  }

  addCartItemToCartList(CartItem cartItem) async {
    emit(CartLoading());

    final response = await addCartItemToCartListUseCase(cartItem);

    response.fold(
        (failure) => emit(CartAddItemFailState(message: failure.message)),
        (success) =>
            emit(const CartAddItemSuccesState(message: 'Item Added To Cart')));
  }

  getCartItems() async {
    emit(CartLoading());

    final respone = await getCartItemsUseCase();

    respone.fold(
        (failure) => emit(CartLoadingFailedState(message: failure.message)),
        (success) => emit(CartLoadedSuccessState(cartitems: success)));

  }
}
