import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/add_post_api_response.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';
import 'package:spott/utils/enums.dart';

part 'create_post_cubit_state.dart';

class CreatePostCubit extends Cubit<CreatePostCubitState> {
  final Repository _repository = Repository();

  CreatePostCubit() : super(CreatePostCubitInitial());

  Future<void> createNewPost({
    required String content,
    required double lat,
    required double lng,
    required Place place,
    Uint8List? media,
    MediaType? mediaType,
  }) async {
    if (AppData.accessToken != null) {
      emit(CreatingNewPost());
      final _formData = FormData.fromMap({
        'content': content,
        'lat': lat,
        'lng': lng,
        'address': 'address',
        'privacy[]': 'all',
        'place_id': place.id,
        'media[0]': (mediaType == MediaType.image && media != null)
            ? MultipartFile.fromBytes(media, filename: 'image.png')
            : null,
        'type': mediaType == MediaType.video
            ? 'video'
            : mediaType == MediaType.image
                ? 'image'
                : 'text',
        'videoFile': (mediaType == MediaType.video && media != null)
            ? MultipartFile.fromBytes(media, filename: 'video.mp4')
            : null,
        'place_type': place.userId != null ? 'site' : 'foursquare',
        'place': place.userId != null ? null : place.toJson(),
      });

      print('Data of fields => ${_formData.fields}');
      final AddPostApiResponse _apiResponse =
          await _repository.addNewPost(AppData.accessToken!, _formData);
      if (_apiResponse.status == ApiResponse.success) {
        emit(
          PostCreatedSuccessfully(_apiResponse),
        );
      } else {
        emit(
          ErrorState(_apiResponse.message ?? LocaleKeys.addPostFailed.tr()),
        );
      }
    }
  }
}
