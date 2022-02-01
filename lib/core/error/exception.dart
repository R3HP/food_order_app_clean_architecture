import 'package:equatable/equatable.dart';

abstract class Exception extends Equatable{
  final String message;
  const Exception(this.message);
}

class ServerException extends Exception{
  const ServerException(String message):super(message);
  @override
  List<Object?> get props => [message];
}