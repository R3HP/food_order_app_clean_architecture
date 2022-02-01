part of 'food_cubit.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodInitialState extends FoodState {} 


class FoodLoadingState extends FoodState{}

class FoodsLoadedState extends FoodState {
  final List<FoodModel> usecaseResponse;
  const FoodsLoadedState({
    required this.usecaseResponse,
  });

  @override
  // TODO: implement props
  List<Object> get props => [usecaseResponse];
}


class FoodDetailState extends FoodState {
  final FoodModel food;
  const FoodDetailState({
    required this.food,
  });
  @override
  // TODO: implement props
  List<Object> get props => [food];
}


class FoodLoadingError extends FoodState {
  final Failure failure;

  const FoodLoadingError({
    required this.failure,
  });

  @override
  // TODO: implement props
  List<Object> get props => [failure];
}
