import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_app/core/error/exception.dart';
import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

main() {
  Supabase.initialize(
    url: 'https://cogemafmwhqnlsvergqx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzNDQwMjQzMiwiZXhwIjoxOTQ5OTc4NDMyfQ.wnLn0fxdSQsI8pEeKKK2H4cjc8jkpnUVVtY0S6h94SQ',
  );

  test('dddd',()async{
    try{
      final response = await Supabase.instance.client.from('foods').select().execute();
      if(response.status! >= 300){
        throw ServerException(response.error!.message);
      }else{
        print('response $response');
        final data = response.data as List<Map<String,dynamic>>;
        print('data $data');
        final foodList = data.map((e) => FoodModel.fromMap(e)).toList();
        print('foodList $foodList');
        // return foodList;
      }
    }catch (error){
      throw ServerException(error.toString());
    }
  });
}
