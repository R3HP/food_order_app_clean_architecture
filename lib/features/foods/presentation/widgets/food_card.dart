import 'package:flutter/material.dart';
import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:food_order_app/features/foods/presentation/screens/food_detail_screen.dart';

class FoodCard extends StatelessWidget {
  final FoodModel foodModel;
  const FoodCard({Key? key, required this.foodModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(FoodDetailsScreen.ROUTE_NAME,arguments: {'foodModel' : foodModel}),
      child: Container(
        width: 200,
        margin: const EdgeInsets.all(8.0),
        child: ClipRRect(
          
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                foodModel.pictures[0],
                fit: BoxFit.fill,
              ),
              Positioned(
                top: 1,
                left: 5,
                child: Chip(
                  backgroundColor: Colors.amber.withOpacity(0.7),
                  label: Text(
                    foodModel.categories.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  elevation: 10,
                ),
              ),
              if (foodModel.priceOff > 0)
                Positioned(
                  top: 1,
                  right: 5,
                  child: Chip(
                    backgroundColor: Colors.amber.withOpacity(0.7),
                    label: Text(
                      foodModel.priceOff.toString(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    elevation: 10,
                  ),
                ),
              Positioned(
                bottom: 2,
                left: 5,
                right: 5,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                      gradient:const LinearGradient(colors: [Colors.black54,Colors.black] , begin: Alignment.topCenter,end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: Text(foodModel.name,style: const TextStyle(color: Colors.greenAccent,fontSize: 15,fontWeight: FontWeight.w600),)),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            foodModel.price.toString(),
                            style: TextStyle(
                                color: Colors.greenAccent,
                                decoration: foodModel.priceOff == 0
                                    ? TextDecoration.underline
                                    : TextDecoration.lineThrough),
                          ),
                          if(foodModel.priceOff != 0)
                          Text(
                            foodModel.getSellingPrice().toStringAsFixed(2),
                            style: const TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline),
                          ),
                          
                        ],
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          onPrimary: Colors.greenAccent
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_bag),
                        label: const Text('ADD TO CART'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
