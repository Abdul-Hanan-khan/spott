import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/authentication_cubits/reset_password_cubit/reset_password_cubit.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/authentication_screens/reset_password_screens/enter_confirmation_code_screen.dart';
import 'package:spott/ui/screens/authentication_screens/reset_password_screens/update_password_screen.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/authentication_text_field.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/constants/ui_constants.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocListener<ResetPasswordCubit, ResetPasswordCubitState>(
        listener: (context, state) {
          if (state is PasswordResetFailedState) {
            showSnackBar(context: context, message: state.message);
          } else if (state is ResetPasswordEmailSent) {
            if (state.message != null) {
              showSnackBar(context: context, message: state.message!);
            }
            _navigateToConfirmationCodeScreen(context, state.email);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.forgottenPassword.tr(),style: const TextStyle(
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
                     Text(
                        LocaleKeys.justTellUsYourEmailAndSendYouAnEmailSoYouCanResetIt.tr()),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthenticationTextField(
                      controller: _emailTextEditingController,
                      hintText: LocaleKeys.email.tr(),
                      icon: const Icon(Icons.email),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<ResetPasswordCubit, ResetPasswordCubitState>(
                      builder: (context, state) {
                        return AppButton(
                          text: LocaleKeys.send.tr(),
                          isLoading: state is LoadingState,
                          onPressed: () => _onSendButtonPressed(context),
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

  void _navigateToConfirmationCodeScreen(BuildContext context, String email) {
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => EnterConfirmationCodeScreen(email),
    //   ),
    // );

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => UpdatePasswordScreen(email: _emailTextEditingController.text,)));
  }

  void _onSendButtonPressed(BuildContext context) {
    if (isEmailValid(_emailTextEditingController.text)) {
      context
          .read<ResetPasswordCubit>()
          .sendResetPasswordEmail(_emailTextEditingController.text);
    }
  }
}
