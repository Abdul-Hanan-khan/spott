import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/authentication_cubits/reset_password_cubit/reset_password_cubit.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/authentication_text_field.dart';
import 'package:spott/utils/constants/ui_constants.dart';
import 'package:spott/utils/show_snack_bar.dart';

class UpdatePasswordScreen extends StatefulWidget {
  final String email;
  const UpdatePasswordScreen({required this.email, Key? key}) : super(key: key);

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController _passwordTextController = TextEditingController();

  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

  final TextEditingController _codeTextEditingController =
      TextEditingController();

  String? _passwordFieldErrorMessage;

  String? _confirmPasswordFieldErrorMessage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocListener<ResetPasswordCubit, ResetPasswordCubitState>(
        listener: (context, state) {
          if (state is PasswordResetFailedState) {
            showSnackBar(context: context, message: state.message);
          } else if (state is PasswordUpdatedSuccessfully) {
            _navigateToLoginScreen(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.updatePassword.tr(),
                style: const TextStyle(
                  color: Colors.black,
                )),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: UiConstants.getFormPadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.13,
                    ),
                    Text(LocaleKeys.pleaseEnterNewPassword.tr()),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthenticationTextField(
                      controller: _codeTextEditingController,
                      hintText: LocaleKeys.confirmationCode.tr(),
                      isPassword: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthenticationTextField(
                      controller: _passwordTextController,
                      hintText: LocaleKeys.password.tr(),
                      icon: const Icon(Icons.lock),
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      errorMessage: _passwordFieldErrorMessage,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthenticationTextField(
                      controller: _confirmPasswordTextController,
                      hintText: LocaleKeys.confirmPassword.tr(),
                      icon: const Icon(Icons.lock),
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      errorMessage: _confirmPasswordFieldErrorMessage,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<ResetPasswordCubit, ResetPasswordCubitState>(
                      builder: (context, state) {
                        return AppButton(
                          text: LocaleKeys.update.tr(),
                          isLoading: state is LoadingState,
                          onPressed: () => _onUpdateButtonPressed(context),
                        );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isFormValid() {
    if (_passwordTextController.text.isEmpty) {
      if (_passwordFieldErrorMessage == null) {
        setState(() {
          _passwordFieldErrorMessage = LocaleKeys.enterPassword.tr();
        });
      }
      return false;
    } else if (_passwordFieldErrorMessage != null) {
      setState(() {
        _passwordFieldErrorMessage = null;
      });
    }
    if (_confirmPasswordTextController.text != _passwordTextController.text) {
      if (_confirmPasswordFieldErrorMessage == null) {
        setState(() {
          _confirmPasswordFieldErrorMessage =
              LocaleKeys.confirmPasswordNotValid.tr();
        });
      }
      return false;
    } else if (_confirmPasswordFieldErrorMessage != null) {
      setState(() {
        _confirmPasswordFieldErrorMessage = null;
      });
    }

    return true;
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _onUpdateButtonPressed(BuildContext context) {
    if (_codeTextEditingController.text.length != 6) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter 6 digit code")));
      return;
    }
    if (_isFormValid()) {
      context.read<ResetPasswordCubit>().updateUserPassword(
          email: widget.email,
          code: _codeTextEditingController.text,
          password: _passwordTextController.text);
    }
  }
}
