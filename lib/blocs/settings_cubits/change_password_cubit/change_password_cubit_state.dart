part of 'change_password_cubit.dart';

abstract class ChangePasswordCubitState extends Equatable {
  const ChangePasswordCubitState();

  @override
  List<Object> get props => [];
}

class ChangePasswordCubitInitial extends ChangePasswordCubitState {}

class ChangingPassword extends ChangePasswordCubitState {}

class FailedToChangePassword extends ChangePasswordCubitState {
  final String message;

  const FailedToChangePassword(this.message);
}

class PasswordChangedSuccessFully extends ChangePasswordCubitState {
  final String? message;

  const PasswordChangedSuccessFully(this.message);
}
