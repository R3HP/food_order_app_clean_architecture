import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/accounting/domain/entity/account.dart';
import 'package:food_order_app/features/accounting/domain/repository/account_repository.dart';

class AccountUpdateUseCase {
  final AccountRepository repository;


  AccountUpdateUseCase({
    required this.repository,
  });

  Future<Either<Failure,void>> call(Account newAccount) async {
    final response = await repository.updateAccountWithNewAccount(newAccount);
    return response;
  }
  
}
