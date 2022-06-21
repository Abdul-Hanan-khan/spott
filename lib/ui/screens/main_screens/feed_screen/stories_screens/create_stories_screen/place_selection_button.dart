import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/other_screens/place_selection_screens/place_selection_screen.dart';

class PlaceSelectionButton extends StatefulWidget {
  final Function(Place _place) _onPlaceSelection;
  const PlaceSelectionButton(
    this._onPlaceSelection, {
    Key? key,
  }) : super(key: key);

  @override
  _PlaceSelectionButtonState createState() => _PlaceSelectionButtonState();
}

class _PlaceSelectionButtonState extends State<PlaceSelectionButton> {
  Place? _selectedPlace;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onWhereAreYouButtonTapped,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        primary: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/building.svg'),
          const SizedBox(
            width: 5,
          ),
          Container(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedPlace == null
                      ? LocaleKeys.whereAreYou.tr()
                      : _selectedPlace?.name ?? '',
                  textAlign: TextAlign.center,
                ),
                if (_selectedPlace != null)
                  Text(
                    _selectedPlace?.fullAddress ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                        color: Colors.black, fontWeight: FontWeight.w200),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onWhereAreYouButtonTapped() async {
    _selectedPlace = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PlaceSelectionScreen(),
      ),
    );
    setState(() {});
    if (_selectedPlace != null) widget._onPlaceSelection.call(_selectedPlace!);
  }
}
