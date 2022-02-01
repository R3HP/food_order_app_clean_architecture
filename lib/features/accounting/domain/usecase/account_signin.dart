import 'package:dartz/dartz.dart';
import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/accounting/domain/entity/account.dart';
import 'package:food_order_app/features/accounting/domain/repository/account_repository.dart';

class AccountSignInUseCase {
  final AccountRepository repository;

  AccountSignInUseCase({
    required this.repository,
  });

  Future<Either<Failure,Account>> call(String email,String password) async {
    final response = await repository.signInUserWithEmail(email, password);
    return response;
  }


}
