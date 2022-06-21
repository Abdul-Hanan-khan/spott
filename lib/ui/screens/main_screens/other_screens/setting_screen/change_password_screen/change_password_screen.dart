import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/settings_cubits/change_password_cubit/change_password_cubit.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/app_text_field.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/show_snack_bar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class NoScalingAnimation extends FloatingActionButtonAnimator {
  @override
  Offset getOffset({Offset? begin, required Offset end, double? progress}) {
    return end;
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();
  final TextEditingController _oldPasswordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.changePassword.tr(),style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500
          ),
          ),
        ),
        backgroundColor: AppColors.secondaryBackGroundColor,
        floatingActionButtonAnimator: NoScalingAnimation(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0.0
            ? null
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 30),
                child:
                    BlocConsumer<ChangePasswordCubit, ChangePasswordCubitState>(
                  listener: _cubitListener,
                  builder: (context, state) {
                    return AppButton(
                      text: LocaleKeys.updatePassword.tr(),
                      isLoading: state is ChangingPassword,
                      onPressed: () => _onUpdatePasswordButtonPressed(context),
                    );
                  },
                ),
              ),
        body: ListView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
          children: [
            AppTextField(
              hintText: LocaleKeys.newPassword.tr(),
              isPassword: true,
              controller: _newPasswordTextEditingController,
            ),
            const SizedBox(
              height: 20,
            ),
            AppTextField(
              hintText: LocaleKeys.confirmPassword.tr(),
              isPassword: true,
              controller: _confirmPasswordTextEditingController,
            ),
            const SizedBox(
              height: 50,
            ),
            AppTextField(
              hintText: LocaleKeys.oldPassword.tr(),
              isPassword: true,
              controller: _oldPasswordTextEditingController,
            ),
          ],
        ),
      ),
    );
  }

  void _cubitListener(BuildContext context, ChangePasswordCubitState state) {
    if (state is FailedToChangePassword) {
      showSnackBar(context: context, message: state.message);
    }
    if (state is PasswordChangedSuccessFully) {
      if (state.message != null) {
        showSnackBar(context: context, message: state.message!);
      }
      _oldPasswordTextEditingController.clear();
      _newPasswordTextEditingController.clear();
      _confirmPasswordTextEditingController.clear();
    }
  }

  bool _isFieldsFilled() {
    if (_newPasswordTextEditingController.text.isEmpty) {
      showSnackBar(context: context, message: LocaleKeys.enterNewPassword.tr());
      return false;
    }
    if (_confirmPasswordTextEditingController.text !=
        _newPasswordTextEditingController.text) {
      showSnackBar(
          context: context, message: LocaleKeys.confirmPasswordNotValid.tr());
      return false;
    }
    if (_oldPasswordTextEditingController.text.isEmpty) {
      showSnackBar(context: context, message: LocaleKeys.enterOldPassword.tr());
      return false;
    }
    return true;
  }

  void _onUpdatePasswordButtonPressed(BuildContext context) {
    if (_isFieldsFilled()) {
      context.read<ChangePasswordCubit>().changePassword(
          _oldPasswordTextEditingController.text,
          _newPasswordTextEditingController.text);
    }
  }
}
