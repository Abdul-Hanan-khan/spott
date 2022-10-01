import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/models/api_responses/create_story_api_response.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

import '../../feed_screen_cubits/feed_cubit/feed_cubit.dart';

part 'create_story_cubit_state.dart';

class CreateStoryCubit extends Cubit<CreateStoryCubitState> {
  final Repository _repository = Repository();

  CreateStoryCubit() : super(StoriesCubitInitial());

  Future<void> createNewStory({
    required double lat,
    required double lng,
    required Place place,
    required BuildContext context,
    Uint8List? image,
    String? videoPath,
  }) async {
    if (AppData.accessToken != null) {
      emit(CreatingNewStory());
      final _formData = FormData.fromMap({
        'content': 'content',
        'lat': lat,
        'lng': lng,
        'address': place.fullAddress,
        'privacy[]': 'all',
        'place_id': place.id,
        'media[0]': (image != null)
            ? MultipartFile.fromBytes(image, filename: 'story.png')
            : null,
        'type': (image != null)
            ? 'image'
            : (videoPath != null)
                ? 'video'
                : null,
        'videoFile': (videoPath != null)
            ? await MultipartFile.fromFile(videoPath, filename: 'story.mp4')
            : null,
        'place_type': place.userId != null ? 'site' : 'foursquare',
        'place': place.userId != null ? null : place.toJson(),
      });
      final CreateStroyApiResponse _apiResponse =
          await _repository.createStory(AppData.accessToken!, _formData);
      if (_apiResponse.status == ApiResponse.success) {
         context.read<FeedCubit>().posts.forEach((element) {
           if(element.user!.id == AppData.currentUser!.id){
             element.user!.storyyAvailable=true;
             element.user!.storyySeen=false;

           }
           print(place.lat);
           print(element.place!.lat);

           print(element.place!.lng);
           print(place.lng);

           // element.place!.placeStoryySeen = false;
           if((element.place!.lat == place.lat) && (element.place!.lng == place.lng) ){
               element.place!.placeStoryyAvailable =true;
               element.place!.placeStoryySeen = false;

           }

           // if(element.place!.id == place.id){
           //   element.place!.placeStoryyAvailable =true;
           //   element.place!.placeStoryySeen = false;
           // }
         });
         emit(
          StoryCreatedSuccessfully(_apiResponse),
        );
      } else {
        emit(
          ErrorState(
              _apiResponse.message ?? LocaleKeys.createdStoryFailed.tr()),
        );
      }
    }
  }
}
