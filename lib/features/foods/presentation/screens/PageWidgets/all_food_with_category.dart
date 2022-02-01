import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app/core/model/food_category.dart';
import 'package:food_order_app/features/foods/presentation/widgets/food_with_category_item.dart';

class AllFoodWithCategoryScreen extends StatelessWidget {
  const AllFoodWithCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
            centerTitle: true,
            title: const Text('All You Ever Need'),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: const [
                FoodWithCategoryItem(category: Food_Category.Pizza),
                FoodWithCategoryItem(category: Food_Category.Burger),
                FoodWithCategoryItem(category: Food_Category.Fries),
                FoodWithCategoryItem(category: Food_Category.Pasta),
                FoodWithCategoryItem(category: Food_Category.Pasta),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
