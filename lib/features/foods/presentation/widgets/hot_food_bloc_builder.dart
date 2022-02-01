import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app/features/foods/presentation/cubit/food_cubit.dart';
import 'package:food_order_app/features/foods/presentation/widgets/food_card.dart';


class HotFoodsBlocBuilder extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    context.read<FoodCubit>().loadHotFood();
    return BlocBuilder<FoodCubit, FoodState>(

      builder: (context, state) {
        if (state is FoodInitialState ||
            state is FoodLoadingState ||
            state is FoodDetailState) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is FoodsLoadedState) {
          return SizedBox(
            width: 200,
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.usecaseResponse.length,
                itemBuilder: (context, index) =>
                    FoodCard(foodModel: state.usecaseResponse[index])),
          );
        } else if (state is FoodLoadingError) {
          return Text(state.failure.toString());
        } else {
          return const Text('unexpected Error');
        }
      },
    );
  }
}
