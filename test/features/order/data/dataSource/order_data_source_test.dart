import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_app/core/error/exception.dart';
import 'package:food_order_app/features/accounting/domain/entity/account.dart';
import 'package:food_order_app/features/orders/data/dataSource/order_data_source.dart';
import 'package:food_order_app/features/orders/domain/entity/order.dart';
import 'package:mockito/annotations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:postgrest/postgrest.dart' as postgrest;

import '../../../../fixtures/read_fixtures.dart';
import '../../../accounting/data/dataSource/account_data_source_test.mocks.dart';

@GenerateMocks(
    [Supabase, SupabaseClient, SupabaseQueryBuilder, PostgrestFilterBuilder])
void main() {
  late MockSupabase mockSupabase;
  late MockSupabaseClient mockSupabaseClient;
  late MockSupabaseQueryBuilder mockSupabaseQueryBuilder;
  late MockPostgrestFilterBuilder mockPostgrestFilterBuilder;
  late OrderDataSource dataSource;

  Account testUerAccount = Account(
      id: '123',
      favorits: [],
      orders: [2, 3],
      phone: null,
      email: null,
      username: null,
      created_at: DateTime.now());

  final testOrderList = [
    OrderModel(
        id: 2,
        createdAt: DateTime.parse('2021-11-10T19:51:02.946+00:00'),
        totalPrice: 25.25,
        address: 'ye ja dige',
        items: const [123333, 456666],
        isPaid: false),
    OrderModel(
        id: 3,
        createdAt: DateTime.parse('2021-11-10T19:56:32.018+00:00'),
        address: 'hamijaye',
        isPaid: false,
        items: const [45555, 122222],
        totalPrice: 45.52)
  ];

  final testSuccessResponse = postgrest.PostgrestResponse(
      status: 200,
      data: readFixture('test/fixtures/ordersTableGetAllResponse.json'));
  final testFailResponse = postgrest.PostgrestResponse(
      status: 404,
      error: postgrest.PostgrestError(message: 'fuck this is wrong'));

  final testAddOrderSuccessResponse = postgrest.PostgrestResponse(
      status: 200,
      data: readFixture('test/fixtures/ordersTableAddOrderResponse.json'));

  setUp(() {
    mockSupabase = MockSupabase();
    mockSupabaseClient = MockSupabaseClient();
    mockSupabaseQueryBuilder = MockSupabaseQueryBuilder();
    mockPostgrestFilterBuilder = MockPostgrestFilterBuilder();

    dataSource =
        OrderDataSource(supabase: mockSupabase);
  });

  group('getUsersOrdersDetail', () {
    test('get Users Orders Detail Success', () async {
      //arrange
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.in_(any, any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => testSuccessResponse);

      //act
      final response = await dataSource.getUsersOrdersData( account: testUerAccount);

      //assert
      expect(response, equals(testOrderList));
    });
    test('get Users Orders Detail fail', () async {
      //arrange
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.in_(any, any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => testFailResponse);

      //act
      final response = dataSource.getUsersOrdersData;

      //assert
      expect(response(), throwsA(const TypeMatcher<ServerException>()));
    });
    test('get Users Orders Detail throw fail', () async {
      //arrange
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.in_(any, any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenThrow(const ServerException('fuck it one more time'));

      //act
      final response = dataSource.getUsersOrdersData;

      //assert
      expect(response(), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('add order ', () {
    test(' add order success', () async {
      //arrange
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.insert(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => testAddOrderSuccessResponse);

      //act
      final response = await dataSource.addOrder(testOrderList[0]);

      //assert
      expect(response, equals(testOrderList[0].id));
    });

    test('add  Orders  fail', () async {
      //arrange
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.insert(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => testFailResponse);

      //act
      final response = dataSource.addOrder;

      //assert
      expect(response(testOrderList[0]), throwsA(const TypeMatcher<ServerException>()));
    });
     test('add  Orders throw  fail', () async {
      //arrange
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.insert(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
        .thenThrow(ServerException('fuck this is wrong'));

      //act
      final response = dataSource.addOrder;

      //assert
      expect(response(testOrderList[0]), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('update order ', (){
    test(' update order success', () async {
      //arrange
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.insert(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => testAddOrderSuccessResponse);

      //act
      final response = await dataSource.updateOrder(testOrderList[0]);

      //assert
      expect(response, equals(testOrderList[0].id));
    });

    test('update  Orders  fail', () async {
      //arrange
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.update(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => testFailResponse);

      //act
      final response = dataSource.addOrder;

      //assert
      expect(response(testOrderList[0]), throwsA(const TypeMatcher<ServerException>()));
    });
     test('update  Orders throw  fail', () async {
      //arrange
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.update(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
        .thenThrow(ServerException('fuck this is wrong'));

      //act
      final response = dataSource.addOrder;

      //assert
      expect(response(testOrderList[0]), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
