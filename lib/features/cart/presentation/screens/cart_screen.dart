import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_order_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:food_order_app/features/cart/presentation/widgets/cart_list_item.dart';
import 'package:food_order_app/features/cart/presentation/widgets/checkout_container.dart';


class CartScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void deleteCartItem(int cartItemId) {
    context.read<CartCubit>().deleteCartItemFromList(cartItemId);
  }

  @override
  Widget build(BuildContext context) {
    context.read<CartCubit>().getCartItems();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white60,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          color: Colors.green.shade300,
        ),
        child: BlocConsumer<CartCubit, CartState>(listener: (context, state) {
          if (state is CartDeleteCartItemSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message,
                  style: const TextStyle(
                    color: Colors.white,
                  )),
              backgroundColor: Colors.deepOrange,
            ));
          } else if (state is CartDeleteCartItemFailState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message,
                  style: const TextStyle(
                    color: Colors.white,
                  )),
              backgroundColor: Colors.red,
            ));
          }
        }, builder: (ctx, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is CartLoadedSuccessState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartitems.length,
                    itemBuilder: (ctx, index) => Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CartListItem(
                        cartItem: state.cartitems[index],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      bottom: 50, left: 20, right: 20, top: 60),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    color: Colors.green.shade400,
                  ),
                  child: CheckoutContainer(
                    cartItems: state.cartitems,
                  ),
                )
              ],
            );
          } else if (state is CartLoadingFailedState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unexpected Error'));
          }
        }),
      ),
    );
  }
}


