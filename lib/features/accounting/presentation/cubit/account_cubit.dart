import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:food_order_app/core/error/failure.dart';
import 'package:food_order_app/features/accounting/domain/entity/account.dart';
import 'package:food_order_app/features/accounting/domain/usecase/account_signin.dart';
import 'package:food_order_app/features/accounting/domain/usecase/account_signup.dart';
import 'package:food_order_app/features/accounting/domain/usecase/account_update.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountSignInUseCase accountSignInUseCase;
  final AccountSignUpUseCase accountSignUpUseCase;
  final AccountUpdateUseCase accountUpdateUseCase;

  late final Account currentAccount ;

  AccountCubit(
    this.accountSignInUseCase,
    this.accountSignUpUseCase,
    this.accountUpdateUseCase,
  ) : super(AccountInitial());




  signUpAccount(String email,String password) async {
    emit(AccountInitial());

    final response = await accountSignUpUseCase(email,password);



    response.fold((failure) => emit(AccountError(failure: failure)), 
    (account) {
      print('account signup : $account');
      currentAccount = account;
      emit(AccountDataLoaded(account: account));
    });
  }

  signInAccount(String email , String password) async{
    emit(AccountInitial());
    
    final response = await accountSignInUseCase(email,password);
    print('signin response : $response');

    response.fold((failure) => emit(AccountError(failure: failure)), 
    (account) {
      print('account $account');
      currentAccount = account;
      emit(AccountDataLoaded(account: account));
    });
  }

  
  updateAccount(Account newAccount)async{
    emit(AccountInitial());
    final response = await accountUpdateUseCase(newAccount);

    response.fold((failure) => emit(AccountError(failure: failure)), (r) => emit(AccountDataLoaded(account: newAccount)));
  }
}
