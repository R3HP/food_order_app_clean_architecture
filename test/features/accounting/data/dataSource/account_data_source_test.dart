import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_app/core/error/exception.dart';
import 'package:food_order_app/features/accounting/data/dataSource/account_data_source.dart';
import 'package:food_order_app/features/accounting/domain/entity/account.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase/supabase.dart';

import 'package:gotrue/gotrue.dart' as gotrue;

import 'package:gotrue/src/gotrue_error.dart' as gotrueError;

import 'package:postgrest/postgrest.dart' as postgrest;

import '../../../../fixtures/read_fixtures.dart';
import 'account_data_source_test.mocks.dart';

@GenerateMocks([
  Supabase,
  SupabaseClient,
  SupabaseQueryBuilder,
  PostgrestFilterBuilder,
  GoTrueClient
])
void main() {
  late AccountDataSource dataSource;
  late MockSupabase mockSupabase;
  late MockSupabaseClient mockSupabaseClient;
  late MockSupabaseQueryBuilder mockSupabaseQueryBuilder;
  late MockPostgrestFilterBuilder mockPostgrestFilterBuilder;
  late MockGoTrueClient mockGoTrueClient;

  final testGotrueUser = User(
      id: 'daa7c180-dfc2-40db-976c-00049aaa7d81',
      phone: null,
      email: null,
      appMetadata: null,
      aud: '1234567890',
      createdAt: '2021-11-03T18:23:32.385417+00:00',
      role: 'badbakht',
      updatedAt: 'dirooz',
      userMetadata: null,
      emailConfirmedAt: null,
      lastSignInAt: null,
      phoneConfirmedAt: null);

  final testAccount = Account(
      id: 'daa7c180-dfc2-40db-976c-00049aaa7d81',
      favorits: null,
      orders: null,
      created_at: DateTime.parse('2021-11-03T18:23:32.385417+00:00'),
      email: 'test@email.com',
      phone: null,
      username: null,
      birthday: null);

  GotrueSessionResponse gotrueSessionResponseSuccess = GotrueSessionResponse(
    data: Session(
      accessToken: '12345678910',
      user: testGotrueUser,
    ),
  );
  GotrueSessionResponse gotrueSessionResponseFail = GotrueSessionResponse(
      error: gotrueError.GotrueError('gotrueSessionResponseFail'));

  final postGrestResponseSuccess = postgrest.PostgrestResponse(
    status: 200,
    data: readFixture('test/fixtures/authTableResponse.json'),
  );
  final postGrestResponseFail = postgrest.PostgrestResponse(
      status: 404,
      error:
          postgrest.PostgrestError(message: 'this is postgrestResponseFail'));

  setUp(() {
    mockSupabase = MockSupabase();
    mockSupabaseClient = MockSupabaseClient();
    mockSupabaseQueryBuilder = MockSupabaseQueryBuilder();
    mockPostgrestFilterBuilder = MockPostgrestFilterBuilder();
    mockGoTrueClient = MockGoTrueClient();
    dataSource = AccountDataSource(supabase: mockSupabase);
  });

  group('sign up ', () {
    test('signUp User success', () async {
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(mockGoTrueClient.signUp(any, any))
          .thenAnswer((realInvocation) async => gotrueSessionResponseSuccess);

      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.eq(any, any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => postGrestResponseSuccess);

      //act
      final response = await dataSource.signUpUserWithEmailAndPassword(
          'test@test.com', 'testPassword');

      expect(response, equals(testAccount));
    });
    test('sign up user table fail', () {
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(mockGoTrueClient.signUp(any, any))
          .thenAnswer((realInvocation) async => gotrueSessionResponseSuccess);

      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.eq(any, any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenThrow(ServerException('this is a test  exception'));

      //act 
      final call = dataSource.signUpUserWithEmailAndPassword;

      expect(call('test@test.com','testPassword'), throwsA(TypeMatcher<ServerException>()));
    });
    test('sign up user auth service fail', () {
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(mockGoTrueClient.signUp(any, any))
          .thenAnswer((realInvocation) async => gotrueSessionResponseFail);

      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.eq(any, any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenThrow(ServerException('this is a test  exception'));

      //act 
      final call = dataSource.signUpUserWithEmailAndPassword;

      expect(call('test@test.com','testPassword'), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('sign in', (){
    test('signIn User success', () async {
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(mockGoTrueClient.signIn(email: anyNamed('email'),password:  anyNamed('password')))
          .thenAnswer((realInvocation) async => gotrueSessionResponseSuccess);

      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.eq(any, any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => postGrestResponseSuccess);

      //act
      final response = await dataSource.signInUserWithEmailAndPassword(
          'test@test.com', 'testPassword');

      expect(response, equals(testAccount));
    });
    test('sign in user table fail', () {
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(mockGoTrueClient.signIn(email: anyNamed('email'),password:  anyNamed('password')))
          .thenAnswer((realInvocation) async => gotrueSessionResponseSuccess);

      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.eq(any, any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenThrow(ServerException('this is a test  exception'));

      //act 
      final call = dataSource.signInUserWithEmailAndPassword;

      expect(call('test@test.com','testPassword'), throwsA(TypeMatcher<ServerException>()));
    });
    test('sign in user auth service fail', () {
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(mockGoTrueClient.signIn(email: anyNamed('email'),password:  anyNamed('password')))
          .thenAnswer((realInvocation) async => gotrueSessionResponseFail);

      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.eq(any, any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenThrow(ServerException('this is a test  exception'));

      //act 
      final call = dataSource.signInUserWithEmailAndPassword;

      expect(call('test@test.com','testPassword'), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('update user', () {
    test('update User success', () async {
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(mockGoTrueClient.currentUser).thenReturn(testGotrueUser);
      when(mockGoTrueClient.update(any))
          .thenAnswer((realInvocation) async => GotrueUserResponse(user: testGotrueUser));

      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.update(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.eq(any, any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => postGrestResponseSuccess);

      //act
      final response = await dataSource.updateAccountData(testAccount);

      verify(mockPostgrestFilterBuilder.eq('id', testAccount.id));
      // expect(response, equals(testAccount));
    });
    test('update User  auth server fail', () async {
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(mockGoTrueClient.currentUser).thenReturn(testGotrueUser);
      when(mockGoTrueClient.update(any))
          .thenAnswer((realInvocation) async => GotrueUserResponse(error: gotrueError.GotrueError('this is a test auth server error')));

      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.update(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.eq(any, any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => postGrestResponseSuccess);

      //act
      final call = await dataSource.updateAccountData;

      // verify(mockPostgrestFilterBuilder.eq('id', testAccount.id));
      expect(call(testAccount), throwsA(TypeMatcher<ServerException>()));
    });
    test('update Users table fail', () async {
      when(mockSupabase.client).thenReturn(mockSupabaseClient);
      when(mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(mockGoTrueClient.currentUser).thenReturn(testGotrueUser);
      when(mockGoTrueClient.update(any))
          .thenAnswer((realInvocation) async => GotrueUserResponse(user: testGotrueUser));

      when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.update(any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.eq(any, any))
          .thenReturn(mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.execute())
          .thenAnswer((realInvocation) async => postGrestResponseFail);

      //act
      final call = await dataSource.updateAccountData;

      // verify(mockPostgrestFilterBuilder.eq('id', testAccount.id));
      expect(call(testAccount), throwsA(TypeMatcher<ServerException>()));
    });
    
  });
}
