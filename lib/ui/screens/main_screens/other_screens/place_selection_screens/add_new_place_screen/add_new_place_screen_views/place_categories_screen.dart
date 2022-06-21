import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spott/blocs/places_cubit/places_cubit.dart';
import 'package:spott/models/data_models/place_category.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/error_view.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';

class PlaceCategoriesScreen extends StatefulWidget {
  const PlaceCategoriesScreen({Key? key}) : super(key: key);

  @override
  _PlaceCategoriesScreenState createState() => _PlaceCategoriesScreenState();
}

class _PlaceCategoriesScreenState extends State<PlaceCategoriesScreen> {
  Position? _userPosition;
  final List<PlaceCategory> _categories = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlacesCubit, PlacesState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showSnackBar(context: context, message: state.message);
        } else if (state is PlaceCategoriesFetchedSuccessfully) {
          _categories.clear();
          _categories.addAll(state.categories);
        }
      },
      buildWhen: (oldState, newState) {
        if (newState is FetchingPlaceCategories ||
            newState is ErrorState ||
            newState is PlaceCategoriesFetchedSuccessfully) return true;
        return false;
      },
      builder: (context, state) {
        return LoadingScreenView(
          isLoading: state is FetchingPlaceCategories,
          child: Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.categories.tr(),style: const TextStyle(
                color: Colors.black,
              )),
            ),
            backgroundColor: AppColors.secondaryBackGroundColor,
            body: (state is ErrorState)
                ? Center(
                    child: ErrorView(
                      onRetryPressed: _getPlaceCategories,
                    ),
                  )
                : ListView.builder(
                    itemCount: _categories.length,
                    itemBuilder: (_, index) =>
                        _buildPlaceSelectionTile(_categories[index]),
                  ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _getPlaceCategories();
    super.initState();
  }

  Widget _buildPlaceSelectionTile(PlaceCategory _category) {
    return ListTile(
      contentPadding: const EdgeInsets.all(15),
      tileColor: Colors.white,
      onTap: () => _onCategorySelection(_category),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: _category.image != null
            ? CachedNetworkImageProvider(_category.image!)
            : null,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      title: Text(_category.name ?? ''),
    );
  }

  Future<void> _getPlaceCategories() async {
    _userPosition = await getUserLatLng(context);
    if (_userPosition != null) {
      context.read<PlacesCubit>().getPlaceCategories(
          lat: _userPosition!.latitude, lng: _userPosition!.longitude);
    } else {
      _getPlaceCategories();
    }
  }

  void _onCategorySelection(PlaceCategory _category) {
    Navigator.of(context).pop(_category);
  }
}
