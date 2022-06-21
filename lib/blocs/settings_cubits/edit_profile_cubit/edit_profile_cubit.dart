import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/edit_profile_api_response.dart';
import 'package:spott/models/api_responses/get_profile_api_response.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'edit_profile_cubit_state.dart';

class ProfileCubit extends Cubit<ProfileCubitState> {
  final Repository _repository = Repository();

  ProfileCubit() : super(ProfileCubitInitial());

  Future<void> editProfile({
    String? name,
    String? bio,
    String? address,
    String? city,
    String? country,
    String? lat,
    String? lng,
    String? password,
    String? username,
    String? confirmPassword,
    Uint8List? selectedCoverImage,
    Uint8List? selectedProfileImage,
  }) async {
    if (AppData.accessToken != null) {
      emit(UpdatingProfile());
      final _formData = FormData.fromMap({
        'name': name,
        'bio': bio,
        'username': username,
        'location[address]':
            (address != null && address.isNotEmpty) ? address : null,
        'location[city]': (city != null && city.isNotEmpty) ? city : null,
        'location[country]':
            (country != null && country.isNotEmpty) ? country : null,
        'location[lat]':
            (lat != null && lat.isNotEmpty) ? double.parse(lat) : null,
        'location[lng]':
            (lng != null && lng.isNotEmpty) ? double.parse(lng) : null,
        'password': (password?.isNotEmpty == true) ? password : null,
        'confirm_password':
            (confirmPassword?.isNotEmpty == true) ? confirmPassword : null,
      });
      if (selectedCoverImage != null) {
        _formData.files.add(
          MapEntry(
            'cover_picture',
            MultipartFile.fromBytes(
              selectedCoverImage,
              filename:
                  'cover_image_${DateTime.now().millisecondsSinceEpoch}.png',
            ),
          ),
        );
      }
      if (selectedProfileImage != null) {
        _formData.files.add(
          MapEntry(
            'profile_picture',
            MultipartFile.fromBytes(
              selectedProfileImage,
              filename:
                  'profile_image_${DateTime.now().millisecondsSinceEpoch}.png',
            ),
          ),
        );
      }

      final EditProfileApiResponse apiResponse =
          await _repository.editUserProfile(AppData.accessToken!, _formData);
      if (apiResponse.status == ApiResponse.success) {
        emit(
          ProfileUpdatedSuccessFully(apiResponse),
        );
      } else {
        emit(
          ErrorState(
            apiResponse.message ?? LocaleKeys.updateProfileFailed.tr(),
          ),
        );
      }
    }
  }

  Future<void> getProfile() async {
    if (AppData.accessToken != null) {
      emit(FetchingProfile());
      final GetProfileApiResponse apiResponse =
          await _repository.getUserProfile(AppData.accessToken!);
      if (apiResponse.user != null) {
        emit(ProfileFetchedSuccessFully(apiResponse.user));
      } else {
        emit(
          ErrorState(
            apiResponse.message ?? LocaleKeys.getProfileFailed.tr(),
          ),
        );
      }
    }
  }
}
