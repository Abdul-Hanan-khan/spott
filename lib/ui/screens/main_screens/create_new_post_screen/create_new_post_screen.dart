import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spott/blocs/create_post_cubit/create_post_cubit.dart';
import 'package:spott/blocs/feed_screen_cubits/feed_cubit/feed_cubit.dart'
    hide ErrorState;
import 'package:spott/models/data_models/place.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/enums.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';
import 'media_selection_view.dart';
import 'place_selection_button.dart';

class CreateNewPostScreen extends StatefulWidget {
  final Function _openFeedScreen;

  const CreateNewPostScreen(
    this._openFeedScreen, {
    Key? key,
  }) : super(key: key);

  @override
  _CreateNewPostScreenState createState() => _CreateNewPostScreenState();
}

class _CreateNewPostScreenState extends State<CreateNewPostScreen> {
  final TextEditingController _contentTextEditingController =
      TextEditingController();
  Uint8List? _selectedMedia;
  MediaType? _selectedMediaType;
  Place? _selectedPlace;
  Position? _userPosition;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePostCubit(),
      child: BlocConsumer<CreatePostCubit, CreatePostCubitState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showSnackBar(context: context, message: state.message);
          } else if (state is PostCreatedSuccessfully) {
            _contentTextEditingController.clear();
            _openFeedScreen(
              context,
            );
          }
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading: state is CreatingNewPost,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  LocaleKeys.newSpot.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: SvgPicture.asset('assets/icons/add_post.svg'),
                    onPressed: () => _onCreateNewPostButtonPressed(context),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _contentTextEditingController,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: LocaleKeys.anySpotToday.tr(),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                        filled: true,
                        fillColor: AppColors.secondaryBackGroundColor,
                      ),
                      maxLines:
                          (MediaQuery.of(context).size.height / 25).round(),
                    ),
                  ),
                  PlaceSelectionButton(onPlaceSelection: _onPlaceSelection),
                  const Divider(
                    height: 0,
                  ),
                  MediaSelectionView(
                    onMediaSelection: _onMediaSelection,
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
    super.initState();
    _getUserPosition();
  }

  Future<void> _getUserPosition() async {
    _userPosition = await getUserLatLng(context);
  }

  bool _isAllRequiredFieldsAreFilled() {
    if (_userPosition == null) {
      _getUserPosition();
      return false;
    }
    if (_contentTextEditingController.text.trim() == '') {
      showSnackBar(
          context: context, message: LocaleKeys.postContentMissingError.tr());

      return false;
    }
    if (_selectedPlace?.id == null) {
      showSnackBar(
          context: context, message: LocaleKeys.placeNotSelectedError.tr());

      return false;
    }
    return true;
  }

  void _onCreateNewPostButtonPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_isAllRequiredFieldsAreFilled()) {
      context.read<CreatePostCubit>().createNewPost(
            content: _contentTextEditingController.text,
            lat: _userPosition!.latitude,
            lng: _userPosition!.longitude,
            place: _selectedPlace!,
            media: _selectedMedia,
            mediaType: _selectedMediaType,
          );
    }
  }

  void _onMediaSelection(Uint8List? _media, MediaType? _mediaType) {
    _selectedMedia = _media;
    _selectedMediaType = _mediaType;
  }

  Future<void> _onPlaceSelection(Place? _place) async {
    _selectedPlace = _place;
  }

  void _openFeedScreen(BuildContext context) {
    context.read<FeedCubit>().getAllPosts(
          context: context,
          isFirstTimeLoading: true,
      newPostIsSent: true
        );
    widget._openFeedScreen();
  }
}
