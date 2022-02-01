import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/core/model/food_category.dart';
import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:food_order_app/features/foods/domain/enitity/food.dart';
import 'package:food_order_app/features/foods/domain/usecase/get_all_food.dart';
import 'package:food_order_app/features/foods/domain/usecase/get_filtered_food.dart';
import 'package:food_order_app/features/foods/domain/usecase/get_hot_food.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'food_state.dart';

// mixin HotFoodCubit on HydratedCubit<FoodState>{}

// mixin CategoryFoodCubit on HydratedCubit<FoodState>{}

class FoodCubit extends Cubit<FoodState>  {
  late final GetAllFoodUseCase getAllFoodUsecase;
  late final GetFilteredFood getFilteredFoodUseCase;
  late final GetHotFoodUseCase getHotFoodUseCase;
  FoodCubit(
      {required GetAllFoodUseCase allFood,
      required GetHotFoodUseCase hotFood,
      required GetFilteredFood filteredFood})
      : super(FoodInitialState()) {
    getAllFoodUsecase = allFood;
    getHotFoodUseCase = hotFood;
    getFilteredFoodUseCase = filteredFood;
  }

  loadAllFoodsList() async {
    emit(FoodLoadingState());
    final response = await getAllFoodUsecase();
    response.fold((failure) => emit(FoodLoadingError(failure: failure)), (foodList) => emit(FoodsLoadedState(usecaseResponse: foodList)));
  }

  loadFilteredFood(Food_Category food_category) async {
    print('loadfiltered : $food_category');
    // await clear();
    emit(FoodLoadingState());
    final response = await getFilteredFoodUseCase(food_category);
    response.fold((failure) => emit(FoodLoadingError(failure: failure)), (foodlist) => emit(FoodsLoadedState(usecaseResponse: foodlist)));
  }

  loadHotFood() async {
    emit(FoodLoadingState());
    final response = await getHotFoodUseCase();
    response.fold((fail) => emit(FoodLoadingError(failure: fail)), (list) => emit(FoodsLoadedState(usecaseResponse: list)));
  }

  loadFoodDetailPage(FoodModel foodModel){
    emit(FoodLoadingState());
    emit(FoodDetailState(food: foodModel));
  }

  @override
  FoodState? fromJson(Map<String, dynamic> json) {
    print('from json initiated :: $json');
    try{
      List<FoodModel> foodlist=[];
      final x = json.entries.map((mapEntry) => mapEntry.value.map((foodListItem) => foodlist.add(FoodModel.fromMap(foodListItem))));
      print('x :: $foodlist and ${foodlist.runtimeType}' );
      return FoodsLoadedState(usecaseResponse: foodlist);
    // print('from json initiated :: ${json.entries.map((e) => FoodModel.fromMap(e.value)).toList()}');
      // return FoodsLoadedState(usecaseResponse: json.entries.map((e) => FoodModel.fromMap(e.value)).toList());
      // if(json.){
        // return FoodsLoadedState(usecaseResponse: json.entries.map((mapEntry) => FoodModel.fromMap(mapEntry.value)).toList());
      // }else if(json[]){
      // // FoodsLoadedState(usecaseResponse: json.entries.map((e) => FoodModel.fromMap({e.key:e.value)).toList())
      // FoodsLoadedState(usecaseResponse: json)
      // }
    }catch (e){
      print('foodsLoadedState Failed  :' + e.toString());
      // return null;
    }
    try{
      return FoodDetailState(food: FoodModel.fromMap(json['FoodsDetailState']));

    }catch(e){
      print('foodDetailState Failed  :'+e.toString());
    }
    return null;
    
  }

  @override
  Map<String, dynamic>? toJson(FoodState state) {
    print('toJson has been initiated  :: $state');
    if(state is FoodsLoadedState){
      
      return {'FoodsLoadedState' : state.usecaseResponse.map((foodModel) => foodModel.toMap()).toList()};
      // return {
      //   'state' : 'FoodsLoadedState',
      //   'value' : state.usecaseResponse.map((e) => e.toMap()).toList()
      // };
    }else if(state is FoodDetailState){
      return {'FoodsDetailState' : state.food.toMap()};
      // return{
      //   'state' : 'FoodDetailState',
      //   'value' : state.food.toMap()
      // };
    }
    else{
      return null;
    }
  }
}
