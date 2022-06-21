import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spott/blocs/feed_screen_cubits/feed_cubit/feed_cubit.dart'
    hide ErrorState;
import 'package:spott/blocs/stories_cubits/create_story_cubit/create_story_cubit.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/video_widget.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';

import 'place_selection_button.dart';

class CreateStoriesScreen extends StatefulWidget {
  final Uint8List? image;
  final String? videoPath;
  const CreateStoriesScreen({Key? key, this.image, this.videoPath})
      : super(key: key);

  @override
  _CreateStoriesScreenState createState() => _CreateStoriesScreenState();
}

class _CreateStoriesScreenState extends State<CreateStoriesScreen> {
  Position? _userPosition;
  Place? _selectedPlace;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateStoryCubit(),
      child: BlocConsumer<CreateStoryCubit, CreateStoryCubitState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showSnackBar(context: context, message: state.message);
          } else if (state is StoryCreatedSuccessfully) {
            showSnackBar(
                context: context,
                message: state.apiResponse.message ?? LocaleKeys.success.tr());
            _onStoryCreated(context);
          }
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading: state is CreatingNewStory,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  if (widget.image != null)
                    Center(child: Image.memory(widget.image!)),
                  if (widget.videoPath != null)
                    Center(
                        child: VideoWidget(
                      videoUrl: widget.videoPath,
                    )),
                  SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            PlaceSelectionButton(_onPlaceSelection),
                            const SizedBox(
                              width: 47,
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 10, bottom: 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    primary: Colors.white),
                                onPressed: () => _onSendButtonPressed(context),
                                child: Text(LocaleKeys.send.tr())),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    _getUserPosition();
    super.initState();
  }

  // ignore: use_setters_to_change_properties
  Future<void> _getUserPosition() async {
    _userPosition = await getUserLatLng(context);
  }

  // ignore: use_setters_to_change_properties
  void _onPlaceSelection(Place _place) {
    _selectedPlace = _place;
  }

  Future<void> _onSendButtonPressed(BuildContext context) async {
    if (_selectedPlace == null) {
      showSnackBar(
          context: context, message: LocaleKeys.placeNotSelectedError.tr());
    } else {
      if (_userPosition != null) {
        context.read<CreateStoryCubit>().createNewStory(
              image: widget.image,
              videoPath: widget.videoPath,
              lat: _userPosition!.latitude,
              lng: _userPosition!.longitude,
              place: _selectedPlace!,
            );
      } else {
        _getUserPosition();
      }
    }
  }

  void _onStoryCreated(BuildContext context) async{
    await getUserLatLng(context).then((value) {
      if (value != null && value.longitude != null) {
        BlocProvider.of<FeedCubit>(context).getAllData(
          isFirstTimeLoading: false,
          context: context,
          position: value,
        );
      } else {
        showSnackBar(context: context, message: LocaleKeys.pleaseTurnOnYourLocation.tr());
      }
    }).whenComplete(() {});
    Navigator.of(context).pop();
  }
}
