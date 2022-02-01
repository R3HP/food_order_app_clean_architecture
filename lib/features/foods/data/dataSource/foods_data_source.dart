import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/exception.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:food_order_app/core/model/food_category.dart';
import 'package:food_order_app/features/foods/data/model/food_model.dart';

abstract class FoodDataSource {
  Future<List<FoodModel>> getAllFood();
  Future<List<FoodModel>> getFilteredFood(Food_Category food_category);
  Future<List<FoodModel>> getHotFood();
  // Future<FoodModel> getFoodFromServer();
  // Future<void> saveFoodToCache(FoodModel);
}

class FoodDataSourceImpl implements FoodDataSource {
  final Supabase supabase;
  // final SupabaseClient client;

  FoodDataSourceImpl({
    required this.supabase,
    // required this.client
  });

  @override
  Future<List<FoodModel>> getAllFood() async {
    List<FoodModel> foodList = [];
    try {
      final response = await supabase.client.from('foods').select('*').execute();
      if (response.status! >= 300) {
        throw ServerException(response.error!.message);
      } else {
        final data = response.data as List<dynamic>;
        final foodList =
            (data.map((e) => FoodModel.fromMap(e)).toList() as List<FoodModel>);
        return foodList;
      }
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<FoodModel>> getFilteredFood(Food_Category food_category) async {
    print('data source filted food : $food_category');
    try {
      final response = await supabase.client
          .from('foods')
          .select('*')
          .contains('categories', [food_category.toString()])
          .execute();
      if (response.status! >= 300) {
        throw ServerException(response.error!.message);
      } else {
        final data = response.data as List<dynamic>;
        final filteredFoodList =
            (data.map((e) => FoodModel.fromMap(e)).toList() as List<FoodModel>);
            return filteredFoodList;
      }
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<FoodModel>> getHotFood() async{
    try{
      final response = await supabase.client.from('foods').select('*').gt('priceOFF', 0).order('priceOFF',ascending: false).execute();
      if(response.status! >= 300){
        throw ServerException(response.error!.message);
      }else{
        final data = response.data as List<dynamic>;
        final hotFoodList = (data.map((e) => FoodModel.fromMap(e)).toList() as List<FoodModel>) ;
        return hotFoodList;
      }
    }catch (error){
      throw ServerException(error.toString());
    }
  }

  // @override
  // Future<FoodModel> getFoodFromServer() {
  //   // TODO: implement getFoodFromServer
  //   throw UnimplementedError();
  // }

  // @override
  // Future<void> saveFoodToCache(FoodModel) {
  //   // TODO: implement saveFoodToCache
  //   throw UnimplementedError();
  // }

}
