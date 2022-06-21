import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spott/blocs/places_cubit/places_cubit.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/error_view.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/place_image_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';

import 'add_new_place_screen/add_new_place_screen.dart';

class PlaceSelectionScreen extends StatefulWidget {
  const PlaceSelectionScreen({Key? key}) : super(key: key);

  @override
  _PlaceSelectionScreenState createState() => _PlaceSelectionScreenState();
}

class _PlaceSelectionScreenState extends State<PlaceSelectionScreen> {
  Position? _userPosition;
  final List<Place> _places = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlacesCubit, PlacesState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showSnackBar(context: context, message: state.message);
        } else if (state is PlaceSuggestionsFetchedSuccessfully) {
          if (state.apiResponse.places != null) {
            _places.clear();
            _places.addAll(state.apiResponse.places!);
          }
        }
      },
      buildWhen: (oldState, newState) {
        if (newState is FetchingPlaceSuggestions ||
            newState is ErrorState ||
            newState is PlaceSuggestionsFetchedSuccessfully) return true;
        return false;
      },
      builder: (context, state) {
        return LoadingScreenView(
          isLoading: state is FetchingPlaceSuggestions,
          child: Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.whereAreYou.tr()),
            ),
            backgroundColor: AppColors.secondaryBackGroundColor,
            body: Column(
              children: [
                Expanded(
                  child: (state is ErrorState)
                      ? Center(
                          child: ErrorView(
                          onRetryPressed: _getPlaceSuggestions,
                        ))
                      : ListView.builder(
                          itemCount: _places.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              _buildPlaceSelectionTile(_places[index])),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                  child: AppButton(
                    text: LocaleKeys.addNewPlace.tr(),
                    icon: 'assets/icons/add_place.svg',
                    onPressed: _onAddNewPlaceButton,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _getPlaceSuggestions();
    super.initState();
  }

  Widget _buildPlaceSelectionTile(Place _place) {
    return ListTile(
      tileColor: Colors.white,
      onTap: () => _onPlaceSelection(_place),
      leading: PlaceImageView(
        _place.mainPicture,
      ),
      title: Text(_place.name ?? ''),
      subtitle: Text(_place.fullAddress ?? '',style: const TextStyle(
        fontSize: 10,
          color: Colors.grey, fontWeight: FontWeight.w200)),
    );
  }

  Future<void> _getPlaceSuggestions() async {
    _userPosition ??= await getUserLatLng(context);
    if (_userPosition != null) {
      context.read<PlacesCubit>().getPlaceSuggestions(
          lat: _userPosition!.latitude, lng: _userPosition!.longitude);
    } else {
      _getPlaceSuggestions();
    }
  }

  Future<void> _onAddNewPlaceButton() async {
    final Place? _addedPlace = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddNewPlaceScreen(),
      ),
    );
    if (_addedPlace != null) {
      _onPlaceSelection(_addedPlace);
    }
  }

  void _onPlaceSelection(Place _place) {
    Navigator.of(context).pop(_place);
  }
}
