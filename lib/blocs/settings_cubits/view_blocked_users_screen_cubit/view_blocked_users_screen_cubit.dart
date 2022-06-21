import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/get_blocked_users_api_response.dart';
import 'package:spott/models/api_responses/unblock_user_api_response.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'view_blocked_users_screen_cubit_state.dart';

class ViewBlockedUsersScreenCubit
    extends Cubit<ViewBlockedUsersScreenCubitState> {
  final Repository _repository = Repository();

  ViewBlockedUsersScreenCubit() : super(ViewBlockedUsersScreenCubitInitial());

  Future<void> getBlockedUsers() async {
    if (AppData.accessToken != null) {
      emit(LoadingState());
      final GetBlockedUsersApiResponse apiResponse =
          await _repository.getAllBlockedUsers(
        AppData.accessToken!,
      );
      if (apiResponse.status == ApiResponse.success &&
          apiResponse.users != null) {
        emit(UsersFetched(apiResponse.users!));
      } else {
        emit(ErrorState(
            apiResponse.message ?? LocaleKeys.failedToGetBlockedUsers.tr()));
      }
    }
  }

  Future<void> unBlockUsers(int? _userId) async {
    if (AppData.accessToken != null && _userId != null) {
      emit(LoadingState());
      final UnblockUserApiResponse apiResponse = await _repository.unblockUser(
          AppData.accessToken!, _userId.toString());
      if (apiResponse.status == ApiResponse.success) {
        emit(UserUnblocked(_userId, apiResponse.message));
      } else {
        emit(ErrorState(
            apiResponse.message ?? LocaleKeys.failedToUnblockUser.tr()));
      }
    }
  }
}
