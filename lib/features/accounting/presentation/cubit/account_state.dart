part of 'account_cubit.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {

}

class AccountLoading extends AccountState{}

class AccountDataLoaded extends AccountState {
  final Account account;

  const AccountDataLoaded({
    required this.account,
  });

}

class AccountError extends AccountState {
  final Failure failure;
  const AccountError({
    required this.failure,
  });
}
