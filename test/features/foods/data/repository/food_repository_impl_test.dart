
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_app/core/error/exception.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/core/model/food_category.dart';
import 'package:food_order_app/features/foods/data/dataSource/foods_data_source.dart';
import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:food_order_app/features/foods/data/model/ingridient_model.dart';
import 'package:food_order_app/features/foods/data/repository/food_repository_impl.dart';
import 'package:food_order_app/features/foods/domain/enitity/food.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_repository_impl_test.mocks.dart';

@GenerateMocks([FoodDataSourceImpl])
main() {
  late MockFoodDataSourceImpl mockdataSourceImpl ;
  late FoodRepositoryImp  repositoryImp;
  final testListModel = [
    FoodModel(
      priceOff: 20,
        id: 5,
        createdAt: DateTime.parse("2021-10-21T19:25:27+00:00"),
        name: "Big konohian Burger",
        price: 25.56,
        categories: [Food_Category.Burger, Food_Category.Fries],
        ingridients: [
          IngridientModel(
              name: "'Meat'", size: "'120grms'", imagePath: 'Not Found'),
          IngridientModel(
              name: "'MozerlaaCheese'",
              size: "'50grms'",
              imagePath: 'Not Found'),
          IngridientModel(
              name: "'Tomato'", size: "'20grms'", imagePath: 'Not Found')
        ],
        description: "hmmm this is a TASTY BURGER!!!!",
        pictures: ["no image yet"])
  ];
  final testList = testListModel;

  setUp((){
    mockdataSourceImpl = MockFoodDataSourceImpl();
    repositoryImp = FoodRepositoryImp(dataSource: mockdataSourceImpl);
  });

  group('get all Food', (){
    test('should return right side of either containing FoodList', ()async{
      //arrange
      when(mockdataSourceImpl.getAllFood()).thenAnswer((_) async => testListModel);
      //act
      final response = await repositoryImp.getAllFood();

      expect(response, equals(Right(testList)));
    });
    test('should return left side of either containing ServerFailure', ()async{
      //arrange
      when(mockdataSourceImpl.getAllFood()).thenThrow(ServerException('test throw'));
      //act
      final response = await repositoryImp.getAllFood();

      expect(response, equals(Left(ServerFailure(message: 'test throw'))));
    });
  });

  group('get filtered food', (){
    test('should return right side of either containing FoodList', ()async{
      //arrange
      when(mockdataSourceImpl.getFilteredFood(Food_Category.Fries)).thenAnswer((_) async => testListModel);
      //act
      final response = await repositoryImp.getFilteredFood(Food_Category.Fries);

      expect(response, equals(Right(testList)));
    });
    test('should return left side of either containing ServerFailure', ()async{
      //arrange
      when(mockdataSourceImpl.getFilteredFood(any)).thenThrow(ServerException('test throw'));
      //act
      final response = await repositoryImp.getFilteredFood(Food_Category.Fries);

      expect(response, equals(Left(ServerFailure(message: 'test throw'))));
    });
  });
}