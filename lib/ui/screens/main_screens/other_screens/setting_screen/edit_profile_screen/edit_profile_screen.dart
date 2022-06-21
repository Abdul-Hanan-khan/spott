import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spott/blocs/settings_cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/app_text_field.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';
import 'cover_image_picker_view.dart';
import 'profile_image_picker_view.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameTextEditingController =
  TextEditingController();
  final TextEditingController _userNameTextEditingController =
  TextEditingController();
  final TextEditingController _aboutTextEditingController =
  TextEditingController();
  final TextEditingController _addressTextEditingController =
  TextEditingController();
  final TextEditingController _cityTextEditingController =
  TextEditingController();
  final TextEditingController _countryTextEditingController =
  TextEditingController();
  User? _userProfile;
  Position? _userPosition;
  Uint8List? _selectedCoverImage;
  Uint8List? _selectedProfileImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),
      child: BlocConsumer<ProfileCubit, ProfileCubitState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showSnackBar(context: context, message: state.message);
          } else if (state is ProfileFetchedSuccessFully) {
            _userProfile = state.user;
            _fillForm();
          } else if (state is ProfileUpdatedSuccessFully) {
            showSnackBar(
                context: context, message: state.apiResponse.message ?? '');
          }
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading: state is FetchingProfile,
            child: Scaffold(
              appBar: AppBar(
                title: Text(LocaleKeys.editProfile.tr(),style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                )),
              ),
              backgroundColor: AppColors.secondaryBackGroundColor,
              body: ListView(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                children: [
                  CoverImagePickerView(
                    imageUrl: _userProfile?.coverPicture,
                    onImageSelection: _onCoverImageSelection,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ProfileImagePickerView(
                        _userProfile,
                        onImageSelection: _onProfileImageSelection,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: AppTextField(
                          hintText: LocaleKeys.name.tr(),
                          controller: _nameTextEditingController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: AppTextField(
                      hintText: LocaleKeys.userName,
                      controller: _userNameTextEditingController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    controller: _aboutTextEditingController,
                    hintText: LocaleKeys.about.tr(),
                    keyboardType: TextInputType.multiline,
                    isMultiLine: true,
                  ),

                  //! client ask to hide these
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // AppTextField(
                  //   controller: _addressTextEditingController,
                  //   hintText: "Address",
                  //   keyboardType: TextInputType.streetAddress,
                  //   isMultiLine: true,
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // AppTextField(
                  //   controller: _cityTextEditingController,
                  //   hintText: "City",
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // AppTextField(
                  //   controller: _countryTextEditingController,
                  //   hintText: "Country",
                  // ),

                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 30),
                child: AppButton(
                  text: LocaleKeys.save.tr(),
                  isLoading: state is UpdatingProfile,
                  onPressed: () => _onSaveButtonPressed(context),
                ),
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

  void _fillForm() {
    _nameTextEditingController.text = _userProfile?.name ?? '';
    _aboutTextEditingController.text = _userProfile?.bio ?? '';
    _userNameTextEditingController.text = _userProfile?.username ?? '';
    _addressTextEditingController.text = _userProfile?.address ?? '';
    _cityTextEditingController.text = _userProfile?.city ?? '';
    _countryTextEditingController.text = _userProfile?.country ?? '';
  }

  //ignore: use_setters_to_change_properties
  Future<void> _getUserPosition() async {
    _userPosition = await getUserLatLng(context);
  }

  //ignore: use_setters_to_change_properties
  void _onCoverImageSelection(Uint8List? _image) {
    _selectedCoverImage = _image;
  }

  // ignore: use_setters_to_change_properties
  void _onProfileImageSelection(Uint8List? _image) {
    _selectedProfileImage = _image;
  }

  void _onSaveButtonPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_userPosition != null) {
      context.read<ProfileCubit>().editProfile(
          name: _nameTextEditingController.text,
          username:_userNameTextEditingController.text,
          bio: _aboutTextEditingController.text,
          address: _addressTextEditingController.text,
          city: _cityTextEditingController.text,
          country: _countryTextEditingController.text,
          lat: _userPosition?.latitude.toString(),
          lng: _userPosition?.longitude.toString(),
          selectedCoverImage: _selectedCoverImage,
          selectedProfileImage: _selectedProfileImage);
    } else {
      _getUserPosition();
    }
  }
}
