part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class LoadingState extends SignUpState {}

class SignUpSuccessFull extends SignUpState {
  final String message;

  const SignUpSuccessFull(this.message);
}

class SignUpFailedState extends SignUpState {
  final String? message;
  final SignUpErrorMessages? textFieldMessages;

  const SignUpFailedState({this.message, this.textFieldMessages});
}
