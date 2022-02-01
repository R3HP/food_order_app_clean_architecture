import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/exception.dart';

import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/core/model/food_category.dart';
import 'package:food_order_app/features/foods/data/dataSource/foods_data_source.dart';
import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:food_order_app/features/foods/domain/enitity/food.dart';
import 'package:food_order_app/features/foods/domain/repository/food_repository.dart';

class FoodRepositoryImp implements FoodRepository {
  FoodDataSource dataSource;
  FoodRepositoryImp({
    required this.dataSource,
  });
  @override
  Future<Either<Failure, List<FoodModel>>> getAllFood() async {
    try{
      final response = await dataSource.getAllFood();
      return Right(response);
    }on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch (err){
      return Left(ServerFailure(message: err.toString()));
    }
    
  }

  @override
  Future<Either<Failure, List<FoodModel>>> getFilteredFood(Food_Category food_category) async {
    try{
      final response = await dataSource.getFilteredFood(food_category);
      return Right(response);
    }on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch (err){
      return Left(ServerFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FoodModel>>> getHotFood() async{
    try{
      final response = await dataSource.getHotFood();
      return Right(response);
    }on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch (err){
      return Left(ServerFailure(message: err.toString()));
    }
  }
}
