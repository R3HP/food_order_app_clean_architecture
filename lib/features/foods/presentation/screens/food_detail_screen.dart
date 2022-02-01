import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:food_order_app/features/cart/presentation/screens/cart_screen.dart';

import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:food_order_app/features/foods/presentation/widgets/ingrident_list_item.dart';
import 'package:food_order_app/features/cart/domain/entity/cart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FoodDetailsScreen extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/food_detail';

  FoodDetailsScreen({Key? key}) : super(key: key);

  late FoodModel foodModel;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, FoodModel>;

    foodModel = args['foodModel']!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          //should show item in cart
          IconButton(
            color: Colors.white60,
            icon: const Icon(
              Icons.shopping_bag,
            ),
            onPressed: () => Navigator.of(context).pushNamed(CartScreen.ROUTE_NAME),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Column(
          children: [
            Stack(children: [
              Hero(
                tag: foodModel.id,
                child: CarouselSlider.builder(
                  
                  itemCount: foodModel.pictures.length,
                 itemBuilder: (ctx,index,pageViewIndex) => Image.network(
                  foodModel.pictures[index],
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                 options: CarouselOptions(height: 300,initialPage: 0,reverse: true,viewportFraction: 1,)),
                
              ),
              Positioned(
                  right: 50,
                  left: 50,
                  bottom: 30,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    width: 200,
                    height: 100,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Text(
                        foodModel.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))
            ]),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: foodModel.categories.length,
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.purple),
                          child: Text(
                            foodModel.categories[index].toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Text(foodModel.description),
                    Expanded(
                      child: ListView.builder(
                        itemCount: foodModel.ingridients.length,
                        itemBuilder: (ctx, index) => IngridientListItem(
                            ingridient: foodModel.ingridients[index]),
                      ),
                    ),
                    BlocConsumer<CartCubit, CartState>(
                        builder: (ctx, state) => state is CartLoading
                            ? Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                              color: Colors.orange,
                              child: const Center(child:  CircularProgressIndicator.adaptive(backgroundColor: Colors.white,)))
                            : ElevatedButton(
                                onPressed: () => showAddOrderDialog(context),
                                child: Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  shadowColor: Colors.deepOrange,
                                ),
                              ),
                        listener: (ctx, state) {
                          print('state $state');
                          if (state is CartAddItemFailState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                state.message,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.red,
                            ));
                          } else if (state is CartAddItemSuccesState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                state.message,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.green,
                            ));
                            Navigator.of(context).pop();
                          }
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CartItem createCartItem(int quantity) {
    print('foodModel Id : ${foodModel.id}');
    return CartItem(
        userId: Supabase.instance.client.auth.currentUser!.id,
        productId: foodModel.id,
        pricePerOne: foodModel.price,
        totalPrice: quantity * foodModel.getSellingPrice(),
        quantity: quantity,
        productName: foodModel.name,
        imagePath: foodModel.pictures.first
        );
  }

  showAddOrderDialog(BuildContext context) {
    var quantity = 1;
    showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
              builder: (context, setState) => Dialog(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('is One Really Enough for You?'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                            color: Colors.red,
                            child: const Icon(Icons.exposure_minus_1_rounded),
                            onPressed: (quantity - 2).isNegative
                                ? null
                                : () {
                                    setState(() {
                                      quantity -= 1;
                                    });
                                  }),
                        Text(
                          quantity.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                        MaterialButton(
                            color: Colors.green,
                            child: const Icon(Icons.plus_one_rounded),
                            onPressed: () {
                              setState(() {
                                quantity += 1;
                              });
                            }),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          final cartItem = createCartItem(quantity);
                          context
                              .read<CartCubit>()
                              .addCartItemToCartList(cartItem);
                        },
                        child: const Text('Submit Order'))
                  ],
                ),
                backgroundColor: Colors.white.withOpacity(0.85),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ));
  }
}
