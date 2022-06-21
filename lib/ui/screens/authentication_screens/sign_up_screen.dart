import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/authentication_cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:spott/models/api_responses/sign_up_api_response.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/authentication_screens/term_and_conditions_check_box_view.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/authentication_text_field.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/constants/ui_constants.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();
  String? _userNameFieldErrorMessage;
  String? _emailFieldErrorMessage;
  String? _passwordFieldErrorMessage;
  String? _confirmPasswordFieldErrorMessage;

  bool _isAgreedWithTerms = false;

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailedState) {
            if (state.message != null && state.textFieldMessages == null) {
              showSnackBar(context: context, message: state.message!);
            }
            if (state.textFieldMessages != null) {
              _setErrorMessages(state.textFieldMessages!);
            }
          } else if (state is SignUpSuccessFull) {
            showSnackBar(context: context, message: state.message);
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.signUp.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                  )),
            ),
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Scaffold(
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: UiConstants.getFormPadding(context),
                      child: Center(
                        child: Column(
                          children: [
                            AuthenticationTextField(
                              controller: _userNameTextController,
                              hintText: LocaleKeys.userName.tr(),
                              icon: const Icon(
                                  CupertinoIcons.person_crop_circle_fill),
                              errorMessage: _userNameFieldErrorMessage,
                            ),
                            _buildTextFieldSpacer(),
                            AuthenticationTextField(
                              controller: _emailTextController,
                              hintText: LocaleKeys.email.tr(),
                              icon: const Icon(Icons.email),
                              keyboardType: TextInputType.emailAddress,
                              errorMessage: _emailFieldErrorMessage,
                            ),
                            _buildTextFieldSpacer(),
                            AuthenticationTextField(
                              controller: _passwordTextController,
                              hintText: LocaleKeys.password.tr(),
                              icon: const Icon(Icons.lock),
                              keyboardType: TextInputType.visiblePassword,
                              isPassword: true,
                              errorMessage: _passwordFieldErrorMessage,
                            ),
                            _buildTextFieldSpacer(),
                            AuthenticationTextField(
                              controller: _confirmPasswordTextController,
                              hintText: LocaleKeys.confirmPassword.tr(),
                              icon: const Icon(Icons.lock),
                              keyboardType: TextInputType.visiblePassword,
                              isPassword: true,
                              errorMessage: _confirmPasswordFieldErrorMessage,
                            ),
                            SizedBox(
                              height: _screenSize.height / 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TermAndConditionsCheckBoxView(
                                onChange: _onTermsAndConditionsCheckBoxChange,
                              ),
                            ),
                            SizedBox(
                              height: _screenSize.height / 20,
                            ),
                            AppButton(
                              text: LocaleKeys.signUp.tr(),
                              isLoading: state is LoadingState,
                              onPressed: () => _onSignUpButtonPressed(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.alreadyHaveAnAccount.tr(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      LocaleKeys.signIn.tr(),
                      style:
                          const TextStyle(fontSize: 15, color: AppColors.green),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }

  Widget _buildTextFieldSpacer() => SizedBox(
        height: MediaQuery.of(context).size.height / 50,
      );

  bool _isFormValid() {
    if (_userNameTextController.text.isEmpty) {
      if (_userNameFieldErrorMessage == null) {
        setState(() {
          _userNameFieldErrorMessage = LocaleKeys.enterUserNameError.tr();
        });
      }
      return false;
    } else if (_userNameFieldErrorMessage != null) {
      setState(() {
        _userNameFieldErrorMessage = null;
      });
    }
    if (!isEmailValid(_emailTextController.text)) {
      if (_emailFieldErrorMessage == null) {
        setState(() {
          _emailFieldErrorMessage = LocaleKeys.emailIsNotValid.tr();
        });
      }
      return false;
    } else if (_emailFieldErrorMessage != null) {
      setState(() {
        _emailFieldErrorMessage = null;
      });
    }
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
    if (!_isAgreedWithTerms) {
      showSnackBar(
        context: context,
        message: LocaleKeys.termsConditionError.tr(),
      );
      return false;
    }

    return true;
  }

  void _onSignUpButtonPressed(BuildContext context) {
    if (_isFormValid()) {
      context.read<SignUpCubit>().signUp(
          username: _userNameTextController.text,
          email: _emailTextController.text,
          password: _passwordTextController.text,
          confirmPassword: _confirmPasswordTextController.text);
    }
  }

  void _onTermsAndConditionsCheckBoxChange(
      bool _isAgreedWithTerms, bool _isNotUnderAge) {
    if (_isAgreedWithTerms && _isNotUnderAge) {
      this._isAgreedWithTerms = true;
    } else {
      this._isAgreedWithTerms = false;
    }
  }

  void _setErrorMessages(SignUpErrorMessages _messages) {
    if (_messages.userName != null && _messages.userName!.isNotEmpty) {
      setState(() {
        _userNameFieldErrorMessage = _messages.userName!.join(',');
      });
    } else if (_userNameFieldErrorMessage != null) {
      setState(() {
        _userNameFieldErrorMessage = null;
      });
    }

    if (_messages.email != null && _messages.email!.isNotEmpty) {
      setState(() {
        _emailFieldErrorMessage = _messages.email!.join(',');
      });
    } else if (_emailFieldErrorMessage != null) {
      setState(() {
        _emailFieldErrorMessage = null;
      });
    }

    if (_messages.password != null && _messages.password!.isNotEmpty) {
      setState(() {
        _passwordFieldErrorMessage = _messages.password!.join(',');
      });
    } else if (_passwordFieldErrorMessage != null) {
      setState(() {
        _passwordFieldErrorMessage = null;
      });
    }
  }
}
