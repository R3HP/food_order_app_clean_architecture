import 'package:flutter/material.dart';

import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:food_order_app/features/foods/presentation/screens/food_detail_screen.dart';

class FoodListViewItem extends StatelessWidget {
  final FoodModel foodModel;

  const FoodListViewItem({
    Key? key,
    required this.foodModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape:  RoundedRectangleBorder(
          side: BorderSide(width: 1 ,color: Colors.grey.shade100),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15.0), bottomLeft: Radius.circular(15.0)),
        ),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      elevation: 10,
      child: ListTile(
        
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: Image.network(foodModel.pictures.last,width: 100,fit: BoxFit.cover,),
        ),
        title: Text(foodModel.name),
        subtitle: Text(foodModel.priceOff == 0
            ? foodModel.price.toStringAsFixed(2)
            : foodModel.priceOff.toStringAsFixed(2)),
        
        onTap: () => Navigator.of(context).pushNamed(FoodDetailsScreen.ROUTE_NAME,arguments: {'foodModel' : foodModel}),
      ),
    );
  }
}
