import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:food_order_app/features/foods/domain/repository/food_repository.dart';

class GetHotFoodUseCase {
  final FoodRepository repository;
  
  GetHotFoodUseCase({
    required this.repository,
  });

  Future<Either<Failure, List<FoodModel>>> call() async{
    final response =  await repository.getHotFood();
    return response;
  }
}
