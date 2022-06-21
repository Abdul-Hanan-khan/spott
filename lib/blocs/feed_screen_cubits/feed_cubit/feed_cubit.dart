import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/src/provider.dart';
import 'package:spott/models/api_responses/all_posts_pagination_model.dart';
import 'package:spott/models/api_responses/get_posts_api_response.dart';
import 'package:spott/models/api_responses/story_post_api_model.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';

import '../../../variables.dart';

part 'feed_cubit_state.dart';

class FeedCubit extends Cubit<FeedCubitState> {
  final Repository _repository = Repository();
  List<Post> _posts = [];

  FeedCubit() : super(FeedInitial());

  List<Post> get posts => _posts;

  void getAllData({Position? position, bool isFirstTimeLoading = true, BuildContext? context}) {
    if (isFirstTimeLoading) {
      _posts = [];
    }

    if (position == null) {
      print("called getAllData");

      emit(GPSNoState());
      return;
    } else {
      if (AppData.accessToken != null) {
        emit(LoadingInitialData());
        getAllPosts(
          showLoading: false,
          position: position,
          isFirstTimeLoading: isFirstTimeLoading,
          context: context,
        );
        getAllStories(
            showLoading: false,
            data: FormData.fromMap(
              {'lat': position.latitude, 'lng': position.longitude},
            ));
      }
    }
  }

  Future<void> getAllPosts({
    bool showLoading = true,
    Position? position,
    bool? isFirstTimeLoading,
    BuildContext? context,
    bool newPostIsSent = false,
  }) async {
    if (newPostIsSent == false) {
      if (position == null) {
        print("called getAllPosts ");
        emit(GPSNoState());
        return;
      }
    }

    if (isFirstTimeLoading!) {
      _posts = [];
    }
    if (showLoading) emit(LoadingPosts());

    if (isFirstTimeLoading == true) {
      AllPostsPaginationModel apiResponse = AllPostsPaginationModel();

      apiResponse =
          await _repository.getPosts(AppData.accessToken!, position, null);
      if (apiResponse.status == 1) {
        nextPageUrlFeed = apiResponse.data!.nextPageUrl;
        addData(apiResponse);
      } else {
        emit(ErrorState(apiResponse.message ?? LocaleKeys.getPostFailed.tr()));
      }
    } else {
      AllPostsPaginationModel apiResponse = AllPostsPaginationModel();
      print("Second time fetched going to called ");

      if (nextPageUrlFeed != null) {
        print("Next page url initial => $nextPageUrlFeed");

        apiResponse = await _repository.getPosts(
          AppData.accessToken!,
          position,
          nextPageUrlFeed,
        );

        if (apiResponse.status == 1) {
          print("Next page url initial => $nextPageUrlFeed");
          nextPageUrlFeed = apiResponse.data?.nextPageUrl;
          addData(apiResponse);
        } else {
          emit(
            ErrorState(
              apiResponse.message ?? LocaleKeys.getPostFailed.tr(),
            ),
          );
        }
      } else {
        print("Data is not available");
        print("Post length size => ${_posts.length}");
        emit(PostsFetchedSuccessfully());
        // showSnackBar(context: context!, message: 'No more posts available');
      }
    }
  }

  Future<void> getAllPostInPagination({
    bool showLoading = true,
    Position? position,
  }) async {}

  Future<void> getAllStories(
      {bool showLoading = true, required FormData data}) async {
    if (showLoading) emit(LoadingStories());
    final StoryPostApiModel apiResponse =
        await _repository.getStories(AppData.accessToken!, data);
    print(
        "get all stories data ${apiResponse.data} status ${apiResponse.status}");
    if (apiResponse.status == 1) {
      emit(StoriesFetchedSuccessfully(apiResponse));
    } else {
      print("Error is here get all stories");

      emit(ErrorState(apiResponse.message ?? LocaleKeys.getPostFailed.tr()));
    }
  }

  Future<void> refreshAllData(BuildContext context) async {
    Position? position = await getUserLatLng(context);
    if (position?.latitude == null) {
      print("called refreshAllData");
      emit(GPSNoState());
      return;
    } else {
      print(
          "Position is not null =>  ${position?.latitude} ${position?.longitude}");
    }

    if (position != null) {
      await getUserLatLng(context).then((value) {
        context.read<FeedCubit>().getAllData(position: value, context: context);
      }).whenComplete(() {
        if (AppData.accessToken != null) {
          emit(ReloadingData());
          if (position != null) {
            getAllPosts(
                showLoading: false,
                isFirstTimeLoading: true,
                context: context,
                position: position);
            getAllStories(
                showLoading: false,
                data: FormData.fromMap(
                    {'lat': position.latitude, 'lng': position.longitude}));
          } else {
            showSnackBar(
                context: context,
                message: LocaleKeys.pleaseTurnOnYourLocation.tr());
          }
        }
      });
    } else {
      // getAllStories(showLoading: false,data: FormData.fromMap(   {'lat': position.latitude, 'lng': position.longitude},));
      showSnackBar(
          context: context, message: LocaleKeys.pleaseTurnOnYourLocation.tr());
    }
  }

  addData(AllPostsPaginationModel apiResponse) {
    if (apiResponse.data != null) {
      _posts.addAll(apiResponse.data!.data!);
      emit(PostsFetchedSuccessfully());
    } else if (apiResponse.status == 204) {
      emit(NoPostState());
    } else {
      print("Error is here");

      emit(ErrorState(apiResponse.message ?? LocaleKeys.getPostFailed.tr()));
    }
  }
}
