import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_order_app/dependecy_injection.dart';
import 'package:food_order_app/features/cart/domain/entity/cart.dart';
import 'package:food_order_app/features/cart/domain/usecase/update_item_quantity.dart';
import 'package:food_order_app/features/cart/presentation/cubit/cart_cubit.dart';

class CartListItem extends StatelessWidget {
  final CartItem cartItem;

  const CartListItem({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      onDismissed: (direction) {
        context.read<CartCubit>().deleteCartItemFromList(cartItem.id!);
        context.read<CartCubit>().getCartItems();
      },
      // onDismissed: (direction) => onDismiss(cartItem.id),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.green.shade400,
        ),
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            width: 100,
            height: 100,
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              cartItem.imagePath,
              fit: BoxFit.fill,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(cartItem.productName),
          subtitle: Text(cartItem.totalPrice.toString()),
          trailing: SizedBox(
            child: CounterWidget(cartItem: cartItem),
            width: 106,
          ),
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int _quantity;
  @override
  void initState() {
    super.initState();
    _quantity = widget.cartItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              if (!(_quantity - 2).isNegative) {
                setState(() {
                  _quantity -= 1;
                });
                UpdateItemQuantityUseCase(cartRepository: getIt()).call(
                    _quantity,
                    widget.cartItem.id!,
                    widget.cartItem.totalPrice / widget.cartItem.quantity);
                context.read<CartCubit>().getCartItems();
              }
            },
            icon: const Icon(Icons.remove)),
        Text(_quantity.toString()),
        IconButton(
            onPressed: () {
              setState(() {
                _quantity += 1;
              });
              UpdateItemQuantityUseCase(cartRepository: getIt()).call(
                  _quantity,
                  widget.cartItem.id!,
                  widget.cartItem.totalPrice / widget.cartItem.quantity);
              context.read<CartCubit>().getCartItems();
            },
            icon: const Icon(Icons.add)),
      ],
    );
  }
}
