import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_app/core/error/exception.dart';
import 'package:food_order_app/core/model/food_category.dart';
import 'package:food_order_app/features/foods/data/dataSource/foods_data_source.dart';
import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:food_order_app/features/foods/data/model/ingridient_model.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:postgrest/postgrest.dart' as postgrest;

import '../../../../fixtures/read_fixtures.dart';
import 'foods_data_source_test.mocks.dart';

@GenerateMocks(
    [Supabase, SupabaseClient, SupabaseQueryBuilder, PostgrestFilterBuilder])
main() {
  late MockSupabase mockSupabase;
  late FoodDataSourceImpl dataSourceImpl;
  late MockSupabaseClient mockSupabaseClient;
  late MockSupabaseQueryBuilder mockSupabaseQueryBuilder;
  late MockPostgrestFilterBuilder mockPostgrestFilterBuilder;
  // mockSupabase.client.from(table).execute()
  final testSuccessResponse = postgrest.PostgrestResponse(
      status: 200,
      data:
          json.decode(readFixture('test/fixtures/response.json')));
  final testFailResponse = postgrest.PostgrestResponse(
      status: 400,
      error: postgrest.PostgrestError(message: 'this is test error message'));
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

  setUp(() {
    mockSupabase = MockSupabase();
    dataSourceImpl = FoodDataSourceImpl(supabase: mockSupabase);
    mockSupabaseClient = MockSupabaseClient();
    mockSupabaseQueryBuilder = MockSupabaseQueryBuilder();
    mockPostgrestFilterBuilder = MockPostgrestFilterBuilder();
  });

  test('dddd', (){
    print(json.decode(readFixture('test/fixtures/response.json')));
  });

  group('get all food', () {
    test('should return all foods in mockup', () async {
      //arrange
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.from('foods'))
          .thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select('*'))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => testSuccessResponse);

      //act
      final response = await dataSourceImpl.getAllFood();

      //assert
      expect(response, testListModel);
    });

    test('should throw a ServerException', ()async{
      //arrange
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.from('foods'))
          .thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select('*'))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => testFailResponse);

      //act
      final call = dataSourceImpl.getAllFood;

      //expect
      expect(call(), throwsA(TypeMatcher<ServerException>()));

    });
  });

  group('get filtered Food', (){
    test('should return a list of FoodModels containing food_category', ()async{
      //arrange 

      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.from('foods'))
          .thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select('*'))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.contains('categories', [Food_Category.Fries.toString()])).thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => testSuccessResponse);
      //act 
      final response = await dataSourceImpl.getFilteredFood(Food_Category.Fries);

      //expect 

      expect(response, testListModel);
    });

    test('should throw a ServerException when callen',() async {
      //arrange 

      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.from('foods'))
          .thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select('*'))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.contains('categories', [Food_Category.Fries.toString()])).thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => testFailResponse);
      //act
      final call = dataSourceImpl.getFilteredFood;

      //assert
      expect(call(Food_Category.Fries), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
