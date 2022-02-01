import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/core/model/food_category.dart';
import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:food_order_app/features/foods/data/model/ingridient_model.dart';
import 'package:food_order_app/features/foods/domain/usecase/get_all_food.dart';
import 'package:food_order_app/features/foods/domain/usecase/get_filtered_food.dart';
import 'package:food_order_app/features/foods/domain/usecase/get_hot_food.dart';
import 'package:food_order_app/features/foods/presentation/cubit/food_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:mockito/mockito.dart';

import 'food_cubit_test.mocks.dart';

@GenerateMocks([GetAllFoodUseCase,GetFilteredFood,GetHotFoodUseCase])
main() {
  late FoodCubit foodCubit;
  late MockGetHotFoodUseCase mockGetHotFoodUseCase;
  late MockGetAllFoodUseCase mockGetAllFoodUseCase;
  late MockGetFilteredFood mockGetFilteredFood;
  final ingridients = [
      IngridientModel(name: 'Cheese', size: '150grms', imagePath: ''),
      IngridientModel(name: 'Pepperoni', size: '100grms', imagePath: '')
    ];
    final foodList = [
      FoodModel(
        id: 1,
        createdAt: DateTime.now(),
        pictures: [],
          name: 'Pizza',
          description: 'this is a Pizza ',
          categories: const [Food_Category.Burger, Food_Category.Vegan],
          ingridients: ingridients,
          priceOff: 25,
          price: 25.55)
    ];
    late FoodsLoadedState  foodsLoadedState = FoodsLoadedState(usecaseResponse: foodList);
    ServerFailure serverFailure = ServerFailure(message: 'this is a test failure');
    final errorState  = FoodLoadingError(failure: serverFailure);



  setUp(() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await syspath.getApplicationDocumentsDirectory());
    mockGetFilteredFood = MockGetFilteredFood();
    mockGetAllFoodUseCase = MockGetAllFoodUseCase();
    mockGetHotFoodUseCase = MockGetHotFoodUseCase();
    foodCubit = FoodCubit(allFood: mockGetAllFoodUseCase, filteredFood: mockGetFilteredFood,hotFood: mockGetHotFoodUseCase);
  });

  group('get all food', (){
    
    // test('should be initial state', () {
    //   expect(foodCubit.state, FoodInitialState());
    // });

    test('should emit in irder of [Loading,Loaded]', ()async{
      //arrang
      when(mockGetAllFoodUseCase.call()).thenAnswer((realInvocation) async => Right(foodList));

      //assert
      expectLater(foodCubit.stream, emitsInOrder([FoodLoadingState(),foodsLoadedState]));
      //act
      await foodCubit.loadAllFoodsList();


    });

      test('should emit in irder of [Loading,Error]', ()async{
      //arrang
      when(mockGetAllFoodUseCase.call()).thenAnswer((realInvocation) async => Left(serverFailure));

      //assert
      expectLater(foodCubit.stream, emitsInOrder([FoodLoadingState(),errorState]));
      //act
      await foodCubit.loadAllFoodsList();
    });
  });

  group('get Filtered Food', (){

    // test('should be initial state', () {
    //   expect(foodCubit.state, FoodInitialState());
    // });

    test('should emit in irder of [Loading,Loaded]', ()async{
      //arrang
      when(mockGetFilteredFood.call(Food_Category.Fries)).thenAnswer((realInvocation) async => Right(foodList));

      //assert
      expectLater(foodCubit.stream, emitsInOrder([FoodLoadingState(),foodsLoadedState]));
      //act
      await foodCubit.loadFilteredFood(Food_Category.Fries);


    });

      test('should emit in irder of [Loading,Error]', ()async{
      //arrang
      when(mockGetFilteredFood.call(any)).thenAnswer((realInvocation) async => Left(serverFailure));

      //assert
      expectLater(foodCubit.stream, emitsInOrder([FoodLoadingState(),errorState]));
      //act
      await foodCubit.loadFilteredFood(Food_Category.Fries);
    });
  });

  group('get Hot Food', (){

    // test('should be initial state', () {
    //   expect(foodCubit.state, FoodInitialState());
    // });

    test('should emit in irder of [Loading,Loaded]', ()async{
      //arrang
      when(mockGetHotFoodUseCase.call()).thenAnswer((realInvocation) async => Right(foodList));

      //assert
      expectLater(foodCubit.stream, emitsInOrder([FoodLoadingState(),foodsLoadedState]));
      //act
      await foodCubit.loadHotFood();


    });

      test('should emit in irder of [Loading,Error]', ()async{
      //arrang
      when(mockGetFilteredFood.call(any)).thenAnswer((realInvocation) async => Left(serverFailure));

      //assert
      expectLater(foodCubit.stream, emitsInOrder([FoodLoadingState(),errorState]));
      //act
      await foodCubit.loadFilteredFood(Food_Category.Fries);
    });
  });

  group('FoodDetailPage', (){

    test('should emit in order [Loading,FoodDetalState]', () async {
      //expecLater
      expectLater(foodCubit.stream, emitsInOrder([FoodLoadingState(),FoodDetailState(food: foodList[0])]));

      //act
      await foodCubit.loadFoodDetailPage(foodList[0]);
    });
  });
}  