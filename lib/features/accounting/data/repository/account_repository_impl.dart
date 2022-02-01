import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/exception.dart';

import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/accounting/data/dataSource/account_data_source.dart';
import 'package:food_order_app/features/accounting/domain/entity/account.dart';
import 'package:food_order_app/features/accounting/domain/repository/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountDataSource dataSource;

  AccountRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, Account>> signInUserWithEmail(String email, String password) async {
    try{
    final response = await dataSource.signInUserWithEmailAndPassword(email, password);
    return Right(response);
    } on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch(error){
      return Left(ServerFailure(message: 'Unexpected Error'));
    }

  }

  @override
  Future<Either<Failure, Account>> signUpUserWithEmail(String email, String password) async {
    try{
      final response = await dataSource.signUpUserWithEmailAndPassword(email, password);
      return Right(response);
    }on ServerException catch (e){
      return Left(ServerFailure(message: e.message));
    }catch(error){
      return Left(ServerFailure(message: 'Unexpected Error'));
    }
  }

  @override
  Future<Either<Failure, void>> updateAccountWithNewAccount(Account newAccount) async {
    try{
      final response = await dataSource.updateAccountData(newAccount);
      return Right(response);
    }on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch(error){
      return Left(ServerFailure(message: 'Unexpected Error'));
    }
  }
}
