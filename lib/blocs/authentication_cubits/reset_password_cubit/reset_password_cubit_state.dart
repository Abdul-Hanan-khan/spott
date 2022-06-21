part of 'reset_password_cubit.dart';

abstract class ResetPasswordCubitState extends Equatable {
  const ResetPasswordCubitState();

  @override
  List<Object> get props => [];
}

class ResetPasswordCubitInitial extends ResetPasswordCubitState {}

class LoadingState extends ResetPasswordCubitState {}

class PasswordResetFailedState extends ResetPasswordCubitState {
  final String message;

  const PasswordResetFailedState(this.message);
}

class ResetPasswordEmailSent extends ResetPasswordCubitState {
  final String email;
  final String? message;

  const ResetPasswordEmailSent(this.email, {this.message});
}

class ConfirmationCodeIsValid extends ResetPasswordCubitState {
  final String email, code;
  final String? message;

  const ConfirmationCodeIsValid(this.email, this.code, {this.message});
}

class PasswordUpdatedSuccessfully extends ResetPasswordCubitState {}
