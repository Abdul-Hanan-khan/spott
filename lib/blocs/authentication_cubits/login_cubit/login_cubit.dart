import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spott/models/api_responses/login_api_response.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/preferences_controller.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Repository _repository = Repository();

  LoginCubit() : super(LoginInitial());

  Future<void> loginUserWithEmail(String _email, String _password) async {
    emit(LoggingInUserWithEmail());
    final LoginApiResponse apiResponse =
        await _repository.loginUser(_email, _password);
    if (apiResponse.data?.accessToken != null &&
        apiResponse.data?.user != null) {
      _saveUserInfo(apiResponse.data!.accessToken!, apiResponse.data!.user!);
      emit(LoginSuccessFull());
    } else {
      emit(
        LoginFailedState(apiResponse.message ?? LocaleKeys.loginFailed.tr()),
      );
    }
  }

  Future<void> loginUserWithGoogle() async {
    final Repository repository = Repository();
    await GoogleSignIn(
      scopes: <String>[
        'email',
      ],
    ).signOut();
    await GoogleSignIn(
      scopes: <String>[
        'email',
      ],
    ).signIn().then((value) async {
      final LoginApiResponse apiResponse = await repository.socialLogin(value!.email);

      if (apiResponse.data?.accessToken != null &&
          apiResponse.data?.user != null) {
        _saveUserInfo(apiResponse.data!.accessToken!, apiResponse.data!.user!);
        emit(LoginSuccessFull());
      } else {
        emit(
          LoginFailedState(apiResponse.message ?? LocaleKeys.loginFailed.tr()),
        );
      }
    });
  }

  void _saveUserInfo(
    String _token,
    User _user,
  ) {
    PreferencesController.saveUserInfo(_token, _user);
  }
}
