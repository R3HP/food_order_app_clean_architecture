import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/core/model/food_category.dart';
import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:food_order_app/features/foods/data/model/ingridient_model.dart';
import 'package:food_order_app/features/foods/domain/enitity/food.dart';
import 'package:food_order_app/features/foods/domain/enitity/ingridient.dart';
import 'package:food_order_app/features/foods/domain/repository/food_repository.dart';
import 'package:food_order_app/features/foods/domain/useCase/get_filtered_food.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_filtered_food_test.mocks.dart';

@GenerateMocks([FoodRepository])
main() {
  late MockFoodRepository repository;
  late GetFilteredFood useCase;
  setUp(() {
    repository = MockFoodRepository();
    useCase = GetFilteredFood(repository: repository);
  });

  test('should return a List of Vegan Food', () async {
    //arrange
    final ingridients = [
      IngridientModel(name: 'Cheese', size: '150grms', imagePath: ''),
      IngridientModel(name: 'Pepperoni', size: '100grms', imagePath: '')
    ];
    final foodList = [
      FoodModel(
        priceOff: 20,
          id: 1,
          createdAt: DateTime.now(),
          pictures: [],
          name: 'Pizza',
          description: 'this is a Pizza ',
          categories: const [Food_Category.Burger, Food_Category.Vegan],
          ingridients: ingridients,
          price: 25.55)
    ];
    when(repository.getFilteredFood(Food_Category.Vegan))
        .thenAnswer((realInvocation) async => Right(foodList));

    //act
    final response = await useCase(Food_Category.Vegan);
    //assert
    verify(repository.getFilteredFood(Food_Category.Vegan));
    expect(response, Right(foodList));
    verifyNoMoreInteractions(repository);
  });

  test('should return a [] List when Food_Category is burge', () async {
    //arrange
    final ingridients = [
      IngridientModel(name: 'Cheese', size: '150grms', imagePath: ''),
      IngridientModel(name: 'Pepperoni', size: '100grms', imagePath: '')
    ];
    final foodList = [
      FoodModel(
        priceOff: 20,
          id: 1,
          createdAt: DateTime.now(),
          pictures: [],
          name: 'Pizza',
          description: 'this is a Pizza ',
          categories: const [Food_Category.Burger, Food_Category.Vegan],
          ingridients: ingridients,
          price: 25.55)
    ];
    final emptyList = <FoodModel>[];
    when(repository.getFilteredFood(Food_Category.Burger))
        .thenAnswer((realInvocation) async => Right(emptyList));

    //act
    final response = await useCase(Food_Category.Burger);

    //assert
    expect(response, Right(emptyList));
  });

  test('should return a Failure ', () async {
    //arrange
    when(repository.getAllFood()).thenAnswer(
        (realInvocation) async => Left(ServerFailure(message: 'testMassage')));

    //act
    final response = await repository.getAllFood();

    //assert
    expect(response, Left(ServerFailure(message: 'testMassage')));
  });
}
