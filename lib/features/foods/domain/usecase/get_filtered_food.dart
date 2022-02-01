import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/core/model/food_category.dart';
import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:food_order_app/features/foods/domain/enitity/food.dart';
import 'package:food_order_app/features/foods/domain/repository/food_repository.dart';

class GetFilteredFood {
  final FoodRepository repository;

  GetFilteredFood({
    required this.repository,
  });

  Future<Either<Failure,List<FoodModel>>> call(Food_Category food_category)async{
    final response = await repository.getFilteredFood(food_category);
    return response;
  }
}
