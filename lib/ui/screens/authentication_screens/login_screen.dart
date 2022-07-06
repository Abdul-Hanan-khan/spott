import 'dart:io' show Platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/authentication_cubits/login_cubit/login_cubit.dart';
import 'package:spott/blocs/feed_screen_cubits/feed_cubit/feed_cubit.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/authentication_screens/reset_password_screens.dart/forgot_password_screen.dart';
import 'package:spott/ui/screens/main_screens/main_screen.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/authentication_text_field.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/constants/ui_constants.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';

import '../../../variables.dart';
import 'sign_up_screen.dart';
import 'term_and_conditions_check_box_view.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import '../../../utils/show_snack_bar.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();


  @override
  void initState() {
    getUserLatLng(context).then((value) {
      setState(() {
        position = value;
      });
    });
    super.initState();
  }

  bool locationIsOn = true;

  void _getInitialData(BuildContext context) async {
    final bool isAccepted = await checkLocationPermission();

    if (isAccepted) {
      setState(() {
        locationIsOn = true;
      });

      await getUserLatLng(context).then((value) {
        if (value != null && value.longitude != null) {
          context.read<FeedCubit>().getAllData(position: position);
        } else {
          showSnackBar(context: context, message: LocaleKeys.pleaseTurnOnYourLocation.tr());
        }
      }).whenComplete(() {});
    } else {
      setState(() {
        locationIsOn = false;
      });
    }
  }

  Future<bool> checkLocationPermission() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();

    if (_serviceEnabled) {
      return true;
    } else {
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailedState) {
            showSnackBar(context: context, message: state.message);
          } else if (state is LoginSuccessFull) {

            _getInitialData(context);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>  MainScreen(false),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: UiConstants.getFormPadding(context),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: _screenSize.height / 10,
                          ),
                          Image.asset('assets/images/logo_no_text.png'),
                          SizedBox(
                            height: _screenSize.height / 10,
                          ),
                          AuthenticationTextField(
                            controller: _emailTextController,
                            hintText: LocaleKeys.email.tr(),
                            icon: const Icon(Icons.email),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: _screenSize.height / 80,
                          ),
                          AuthenticationTextField(
                            controller: _passwordTextController,
                            hintText: LocaleKeys.password.tr(),
                            icon: const Icon(Icons.lock),
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                          ),
                          SizedBox(
                            height: _screenSize.height / 100,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => _onForgotPasswordPressed(context),
                              child: Text(
                                LocaleKeys.forgetPassword.tr(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _screenSize.height / 20,
                          ),
                          AppButton(
                            text: LocaleKeys.login.tr(),
                            isLoading: state is LoggingInUserWithEmail,
                            onPressed: () => _onLoginButtonPressed(context),
                          ),
                          SizedBox(
                            height: _screenSize.height / 20,
                          ),
                          AppButton(
                            text: LocaleKeys.connectWithGoogle.tr(),
                            icon: "assets/icons/google_logo.svg",
                            backGroundColor: AppColors.googleColor,
                            isLoading: state is LoggingInUserWithGoogle,
                            onPressed: () => _showTermsAndConditionsSheet(
                              context: context,
                              onAccepted: () =>
                                  _onSignInWithGooglePressed(context),
                            ),
                          ),
                          SizedBox(
                            height: _screenSize.height / 100,
                          ),
                          if (Platform.isIOS)
                            AppButton(
                              text: LocaleKeys.connectWithApple.tr(),
                              icon: "assets/icons/apple_logo.svg",
                              backGroundColor: Colors.black,
                              onPressed: () {},
                            ),
                          SizedBox(
                            height: _screenSize.height / 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.only(bottom: _screenSize.height / 150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.doNotHaveAnAccount.tr(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () => _openSignUpScreen(context),
                    child: Text(
                      LocaleKeys.signUp.tr(),
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

  void _onForgotPasswordPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ForgetPasswordScreen(),
      ),
    );
  }

  void _onLoginButtonPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!isEmailValid(_emailTextController.text)) {
      showSnackBar(
        context: context,
        message: LocaleKeys.emailIsNotValid.tr(),
      );
    } else if (_passwordTextController.text.isEmpty) {
      showSnackBar(
        context: context,
        message: LocaleKeys.enterPassword.tr(),
      );
    } else {
      context.read<LoginCubit>().loginUserWithEmail(
          _emailTextController.text, _passwordTextController.text);
    }
  }

  void _onSignInWithGooglePressed(BuildContext context) async {
    context.read<LoginCubit>().loginUserWithGoogle();
  }

  void _openSignUpScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  void _showTermsAndConditionsSheet(
      {required BuildContext context, required Function onAccepted}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      builder: (builder) {
        return SizedBox(
          height: 160,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.pleaseAgreeWithTermsConditions.tr(),
                ),
                const SizedBox(
                  height: 30,
                ),
                TermAndConditionsCheckBoxView(
                  onChange: (bool _isAgreedWithTerms, bool _isNotUnderAge) {
                    if (_isAgreedWithTerms && _isNotUnderAge) {
                      Navigator.of(context).pop();
                      onAccepted.call();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
