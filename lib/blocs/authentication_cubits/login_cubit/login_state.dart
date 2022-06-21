part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoggingInUserWithEmail extends LoginState {}

class LoginFailedState extends LoginState {
  final String message;

  const LoginFailedState(this.message);
}

class LoginSuccessFull extends LoginState {}

class LoggingInUserWithGoogle extends LoginState {}
