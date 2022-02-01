import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/accounting/domain/entity/account.dart';

abstract class AccountRepository {
  Future<Either<Failure,Account>> signUpUserWithEmail(String email,String password);
  Future<Either<Failure,Account>> signInUserWithEmail(String email,String password);
  Future<Either<Failure,void>> updateAccountWithNewAccount(Account newAccount);
}