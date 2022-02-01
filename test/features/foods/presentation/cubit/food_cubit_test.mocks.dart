// Mocks generated by Mockito 5.0.16 from annotations
// in food_order_app/test/features/foods/presentation/cubit/food_cubit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:food_order_app/core/error/failure.dart' as _i6;
import 'package:food_order_app/core/model/food_category.dart' as _i9;
import 'package:food_order_app/features/foods/data/model/food_model.dart'
    as _i7;
import 'package:food_order_app/features/foods/domain/repository/food_repository.dart'
    as _i2;
import 'package:food_order_app/features/foods/domain/usecase/get_all_food.dart'
    as _i4;
import 'package:food_order_app/features/foods/domain/usecase/get_filtered_food.dart'
    as _i8;
import 'package:food_order_app/features/foods/domain/usecase/get_hot_food.dart'
    as _i10;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeFoodRepository_0 extends _i1.Fake implements _i2.FoodRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetAllFoodUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAllFoodUseCase extends _i1.Mock implements _i4.GetAllFoodUseCase {
  MockGetAllFoodUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FoodRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeFoodRepository_0()) as _i2.FoodRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.FoodModel>>> call() =>
      (super.noSuchMethod(Invocation.method(#call, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.FoodModel>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i7.FoodModel>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.FoodModel>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetFilteredFood].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetFilteredFood extends _i1.Mock implements _i8.GetFilteredFood {
  MockGetFilteredFood() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FoodRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeFoodRepository_0()) as _i2.FoodRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.FoodModel>>> call(
          _i9.Food_Category? food_category) =>
      (super.noSuchMethod(Invocation.method(#call, [food_category]),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.FoodModel>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i7.FoodModel>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.FoodModel>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetHotFoodUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetHotFoodUseCase extends _i1.Mock implements _i10.GetHotFoodUseCase {
  MockGetHotFoodUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FoodRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeFoodRepository_0()) as _i2.FoodRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.FoodModel>>> call() =>
      (super.noSuchMethod(Invocation.method(#call, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.FoodModel>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i7.FoodModel>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.FoodModel>>>);
  @override
  String toString() => super.toString();
}