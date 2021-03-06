// Mocks generated by Mockito 5.0.16 from annotations
// in food_order_app/test/features/foods/domain/usecase/get_all_food_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:food_order_app/core/error/failure.dart' as _i5;
import 'package:food_order_app/core/model/food_category.dart' as _i7;
import 'package:food_order_app/features/foods/data/model/food_model.dart'
    as _i6;
import 'package:food_order_app/features/foods/domain/repository/food_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [FoodRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFoodRepository extends _i1.Mock implements _i3.FoodRepository {
  MockFoodRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.FoodModel>>> getAllFood() =>
      (super.noSuchMethod(Invocation.method(#getAllFood, []),
              returnValue:
                  Future<_i2.Either<_i5.Failure, List<_i6.FoodModel>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.FoodModel>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.FoodModel>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.FoodModel>>> getHotFood() =>
      (super.noSuchMethod(Invocation.method(#getHotFood, []),
              returnValue:
                  Future<_i2.Either<_i5.Failure, List<_i6.FoodModel>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.FoodModel>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.FoodModel>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.FoodModel>>> getFilteredFood(
          _i7.Food_Category? food_category) =>
      (super.noSuchMethod(Invocation.method(#getFilteredFood, [food_category]),
              returnValue:
                  Future<_i2.Either<_i5.Failure, List<_i6.FoodModel>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.FoodModel>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.FoodModel>>>);
  @override
  String toString() => super.toString();
}
