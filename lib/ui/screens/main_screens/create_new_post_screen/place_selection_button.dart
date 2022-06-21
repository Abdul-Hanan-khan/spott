import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/blocs/create_post_cubit/create_post_cubit.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/other_screens/place_selection_screens/place_selection_screen.dart';

class PlaceSelectionButton extends StatefulWidget {
  final Function(Place? _selectedPlace) onPlaceSelection;
  const PlaceSelectionButton({Key? key, required this.onPlaceSelection})
      : super(key: key);

  @override
  _PlaceSelectionButtonState createState() => _PlaceSelectionButtonState();
}

class _PlaceSelectionButtonState extends State<PlaceSelectionButton> {
  Place? _selectedPlace;

  @override
  Widget build(BuildContext context) {
    final bool _isPlaceSelected = _selectedPlace != null;
    return BlocListener<CreatePostCubit, CreatePostCubitState>(
      listener: (context, state) {
        if (state is PostCreatedSuccessfully) {
          setState(() {
            _selectedPlace = null;
          });
        }
      },
      child: ListTile(
        leading: SvgPicture.asset(
          'assets/icons/location.svg',
          color: _isPlaceSelected ? null : Colors.black,
        ),
        title: Text(
          _isPlaceSelected
              ? _selectedPlace?.name ?? ''
              : LocaleKeys.whereAreYou.tr(),
          style: const TextStyle(fontSize: 18),
        ),
        subtitle:
            _isPlaceSelected ? Text(_selectedPlace?.fullAddress ?? '') : null,
        trailing: const Icon(
          CupertinoIcons.forward,
          color: Colors.black,
          size: 25,
        ),
        onTap: _onAddPlaceButtonTapped,
      ),
    );
  }

  Future<void> _onAddPlaceButtonTapped() async {
    _selectedPlace = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PlaceSelectionScreen(),
      ),
    );
    setState(() {});
    widget.onPlaceSelection.call(_selectedPlace);
  }
}
