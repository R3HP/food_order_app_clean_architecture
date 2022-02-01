import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/core/model/food_category.dart';
import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:food_order_app/features/foods/domain/enitity/food.dart';

abstract class FoodRepository {
  Future<Either<Failure,List<FoodModel>>> getAllFood();

  Future<Either<Failure,List<FoodModel>>> getHotFood();

  Future<Either<Failure,List<FoodModel>>> getFilteredFood(Food_Category food_category);
}