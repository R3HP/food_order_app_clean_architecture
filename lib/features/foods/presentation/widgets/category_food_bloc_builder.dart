import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:food_order_app/core/model/food_category.dart';
import 'package:food_order_app/features/foods/presentation/cubit/food_cubit.dart';
import 'package:food_order_app/features/foods/presentation/widgets/food_card.dart';
import 'package:food_order_app/features/foods/presentation/widgets/food_listview_item.dart';


class CategoryFoodBlocBuilder extends StatefulWidget {
  const CategoryFoodBlocBuilder({Key? key}) : super(key: key);

  @override
  _CategoryFoodBlocBuilderState createState() =>
      _CategoryFoodBlocBuilderState();
}


class _CategoryFoodBlocBuilderState extends State<CategoryFoodBlocBuilder> {
  bool isfirst = true;
  var category = 'Categories';

  searchWithFilter(Food_Category food_category) {
    context.read<FoodCubit>().loadFilteredFood(food_category);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          color: Theme.of(context).dividerColor,
          width: double.infinity,
          child: Row(
            children: [
              const Expanded(child: Text('Categories')),
              PopupMenuButton(
                  onSelected: searchWithFilter,
                  child: Text(category),
                  itemBuilder: (context) {
                    return [
                      getMyFoodPopMenuItem(Food_Category.Burger),
                      getMyFoodPopMenuItem(Food_Category.Fries),
                      getMyFoodPopMenuItem(Food_Category.Pasta),
                      getMyFoodPopMenuItem(Food_Category.Pasta),
                      getMyFoodPopMenuItem(Food_Category.Pizza),
                      getMyFoodPopMenuItem(Food_Category.Vegan),
                    ];
                  }),
            ],
          ),
        ),
        BlocBuilder<FoodCubit, FoodState>(
          builder: (context, state) {
            if (state is FoodInitialState ||
                state is FoodLoadingState ||
                state is FoodDetailState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is FoodsLoadedState) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: state.usecaseResponse.length,
                    itemBuilder: (context, index) =>
                        FoodListViewItem(foodModel: state.usecaseResponse[index]),
                    ),
              );

              // child: ListView.builder(
              //   itemCount: state.usecaseResponse.length,
              //   itemBuilder: (context, index) =>
              //       FoodCard(foodModel: state.usecaseResponse[index]),
              // ),
            } else if (state is FoodLoadingError) {
              return Text(state.failure.toString());
            } else {
              return const Text('unexpected Error');
            }
          },
        ),
      ],
    );
  }

  PopupMenuItem<Food_Category> getMyFoodPopMenuItem(
      Food_Category food_category) {
    return PopupMenuItem<Food_Category>(
      onTap: () {
        setState(() {
          category = food_category.toString();
        });
      },
      value: food_category,
      child: Text(food_category.toString()),
    );
  }
}
