import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spott/blocs/places_cubit/places_cubit.dart';
import 'package:spott/models/data_models/place_category.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/app_text_field.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/show_snack_bar.dart';
import 'add_new_place_screen_views/current_address_selection_button_view.dart';
import 'add_new_place_screen_views/image_selections_list_view.dart';
import 'add_new_place_screen_views/place_category_selection_view.dart';

class AddNewPlaceScreen extends StatefulWidget {
  const AddNewPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddNewPlaceScreenState createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends State<AddNewPlaceScreen> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  late Position? _userPosition;
  Address? _currentAddress;
  PlaceCategory? _selectedCategory;
  List<Uint8List> _images = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlacesCubit, PlacesState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showSnackBar(context: context, message: state.message);
        } else if (state is PlaceAddedSuccessfully) {
          Navigator.of(context).pop(state.place);
        }
      },
      builder: (context, state) {
        return LoadingScreenView(
          isLoading: state is AddingNewPlace,
          child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: Text(LocaleKeys.addNewPlace.tr(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600)),
            ),
            backgroundColor: AppColors.secondaryBackGroundColor,
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      Center(
                        child: Text(
                          LocaleKeys.yourCurrentAddress.tr(),
                        ),
                      ),
                      CurrentAddressSelectionButtonView(
                          _onCurrentAddressSelection),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        hintText: LocaleKeys.name.tr(),
                        suffixText: LocaleKeys.points.tr(),
                        controller: _nameTextEditingController,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      PlaceCategorySelectionView(_onCategorySelection),
                      const SizedBox(
                        height: 30,
                      ),
                      ImageSelectionsListView(_onImageSelection),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                  child: AppButton(
                    text: LocaleKeys.addNewPlace.tr(),
                    onPressed: () => _onAddNewPlaceButton(context),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isFormValid() {
    if (_currentAddress == null) {
      showSnackBar(
          context: context, message: LocaleKeys.failedToGetAddress.tr());
      return false;
    }
    if (_nameTextEditingController.text.isEmpty) {
      showSnackBar(
          context: context, message: LocaleKeys.placeNameRequired.tr());
      return false;
    }
    if (_selectedCategory == null) {
      showSnackBar(
          context: context, message: LocaleKeys.failedToGetPlaceCategory.tr());
      return false;
    }
    // if (_images.isEmpty) {
    //   showSnackBar(
    //       context: context, message: LocaleKeys.selectPlaceImages.tr());
    //   return false;
    // }
    return true;
  }

  void _onAddNewPlaceButton(BuildContext context) {
    if (_isFormValid()) {
      context.read<PlacesCubit>().addNewPost(
          lat: _userPosition!.latitude,
          lng: _userPosition!.longitude,
          address: _currentAddress!.addressLine!,
          name: _nameTextEditingController.text,
          categoryId: _selectedCategory!.id,
          images: _images);
    }
  }

  // ignore: use_setters_to_change_properties
  void _onCategorySelection(PlaceCategory _category) {
    _selectedCategory = _category;
  }

// ignore: use_setters_to_change_properties
  void _onCurrentAddressSelection(Position _position, Address _address) {
    _currentAddress = _address;
    _userPosition = _position;
  }

  // ignore: use_setters_to_change_properties
  void _onImageSelection(List<Uint8List> _newImages) {
    _images = _newImages;
  }
}
