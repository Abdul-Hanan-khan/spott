// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:spott/blocs/authentication_cubits/reset_password_cubit/reset_password_cubit.dart';
// import 'package:spott/translations/codegen_loader.g.dart';
// import 'package:spott/ui/ui_components/app_button.dart';
// import 'package:spott/ui/ui_components/authentication_text_field.dart';
// import 'package:spott/utils/constants/ui_constants.dart';
// import 'package:spott/utils/show_snack_bar.dart';
//
// import 'update_password_screen.dart';
//
// class EnterConfirmationCodeScreen extends StatelessWidget {
//   final String _email;
//
//   EnterConfirmationCodeScreen(
//     this._email, {
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ResetPasswordCubit(),
//       child: BlocListener<ResetPasswordCubit, ResetPasswordCubitState>(
//         listener: (context, state) {
//           if (state is PasswordResetFailedState) {
//             showSnackBar(context: context, message: state.message);
//           } else if (state is ConfirmationCodeIsValid) {
//             if (state.message != null) {
//               showSnackBar(context: context, message: state.message!);
//             }
//             _navigateToChangePasswordScreen(context, state.email, state.code);
//           }
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(LocaleKeys.confirmationCode.tr(),
//                 style: const TextStyle(
//                     color: Colors.black, fontWeight: FontWeight.bold)),
//           ),
//           body: Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: UiConstants.getFormPadding(context),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     RichText(
//                       text: TextSpan(
//                         text: LocaleKeys.pleaseCheckYourEmail.tr(),
//                         style: Theme.of(context).textTheme.bodyText1,
//                         children: <TextSpan>[
//                           TextSpan(
//                             text: _email,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1
//                                 ?.copyWith(
//                                     color: Theme.of(context).primaryColor),
//                           ),
//                           TextSpan(text: LocaleKeys.forConfirmationCode.tr()),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     AuthenticationTextField(
//                       controller: _codeTextEditingController,
//                       hintText: LocaleKeys.confirmationCode.tr(),
//                       keyboardType: TextInputType.number,
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     AuthenticationTextField(
//                       controller: _passEditingController,
//                       hintText: "New Password",
//                       keyboardType: TextInputType.text,
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     BlocBuilder<ResetPasswordCubit, ResetPasswordCubitState>(
//                       builder: (context, state) {
//                         return AppButton(
//                           text: LocaleKeys.send.tr(),
//                           isLoading: state is LoadingState,
//                           onPressed: () => _onSendButtonPressed(context),
//                         );
//                       },
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height / 4,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _navigateToChangePasswordScreen(
//       BuildContext context, String _email, String _code) {
//     Navigator.pushReplacement(context,
//         MaterialPageRoute(builder: (context) => UpdatePasswordScreen()));
//   }
//
//   void _onSendButtonPressed(BuildContext context) {
//     context
//         .read<ResetPasswordCubit>()
//         .checkConfirmationCode(_email, _codeTextEditingController.text);
//   }
// }
