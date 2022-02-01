import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app/features/cart/domain/entity/cart.dart';
import 'package:food_order_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:food_order_app/features/orders/domain/entity/order.dart';
import 'package:food_order_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:food_order_app/features/orders/presentation/screens/orders_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CheckoutContainer extends StatelessWidget {
  final _addressController = TextEditingController();

  final List<CartItem> cartItems;

  final deliveryPrice = 10.0;

  CheckoutContainer({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Discount',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '\$' + calculateSubtotal(),
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Delivery', style: TextStyle(fontSize: 16)),
            Text('\$$deliveryPrice', style: TextStyle(fontSize: 16))
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        const Divider(
          color: Colors.orange,
          height: 20,
          thickness: 5,
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total', style: TextStyle(fontSize: 16)),
            Text(getTotalCartPrice())
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state is AddNewOrderFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is AddNewOrderSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ));
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.ROUTE_NAME);
            }
          },
          builder: (context, state) {
            return state is OrderLoadingState
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    color: Colors.orange,
                    child: const Center(
                        child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    )))
                : ElevatedButton(
                    onPressed: () => showAddressBottomSheet(context),
                    child: const Text('Checkout'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shadowColor: Colors.deepOrange,
                      minimumSize: const Size(double.infinity, 50.0),
                      padding: const EdgeInsets.all(7.0),
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

  Future<dynamic> showAddressBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      elevation: 1.0,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))
      ),

                        context: context,
                        builder: (ctx) {
                          return DraggableScrollableSheet(
                            expand: false,
                              minChildSize: 0.1,
                              initialChildSize: 0.2,
                              maxChildSize: 0.7,
                              builder: (ctx, scrollController) {
                                return SingleChildScrollView(
                                  controller: scrollController,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        TextField(
                                          decoration: const InputDecoration(
                                            hintText: 'Enter Your Address',

                                          ),
                                          controller: _addressController,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.deepOrange,
                                            shadowColor: Colors.orange
                                          ),
                                            onPressed: () {
                                              if (_addressController
                                                  .text.isNotEmpty) {
                                                    Navigator.of(context).pop();
                                                final newOrder = OrderModel(
                                                    cartItemsId: cartItems
                                                        .map((e) => e.id!)
                                                        .toList(),
                                                    address: _addressController
                                                        .text
                                                        .trim(),
                                                    cartItemsName: cartItems
                                                        .map((e) =>
                                                            e.productName)
                                                        .toList(),
                                                    totalPrice: double.parse(
                                                        getTotalCartPrice()),
                                                    userId: Supabase
                                                        .instance
                                                        .client
                                                        .auth
                                                        .currentUser!
                                                        .id);
                                                context
                                                    .read<OrderCubit>()
                                                    .addNewOrder(newOrder);
                                                
                                              }
                                            },
                                            child: const Text('Send Me FOOD'))
                                      ],
                                    ),
                                  ),
                                );
                              });
                        });
  }

  String calculateSubtotal() {
    var subtotal = 0.00;
    for (var element in cartItems) {
      final diff =
          ((element.totalPrice / element.quantity) - element.pricePerOne).abs() * element.quantity;
      print('totalPrice : ${element.totalPrice}');
      print('quantity : ${element.quantity}');
      print('pricePerOne : ${element.pricePerOne}');
      print('diff : $diff');
      subtotal += diff;
    }

    // print(subtotal);
    return subtotal.toStringAsFixed(2);
  }

  String getTotalCartPrice() {
    var total = deliveryPrice;
    for (var element in cartItems) {
      // print('total ${element.totalPrice}');
      // print('pricePer ${element.pricePerOne}');
      total += element.totalPrice;
    }

    return total.toStringAsFixed(2);
  }
}