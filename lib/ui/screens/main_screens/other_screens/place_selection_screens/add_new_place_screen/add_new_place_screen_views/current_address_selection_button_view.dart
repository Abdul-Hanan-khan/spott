import 'package:flutter/material.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spott/utils/helper_functions.dart';
import 'nearby_places_selection_screen.dart';

class CurrentAddressSelectionButtonView extends StatefulWidget {
  final Function(Position _position, Address _address)
      _onCurrentAddressSelection;
  const CurrentAddressSelectionButtonView(this._onCurrentAddressSelection,
      {Key? key})
      : super(key: key);

  @override
  _CurrentAddressSelectionButtonViewState createState() =>
      _CurrentAddressSelectionButtonViewState();
}

class _CurrentAddressSelectionButtonViewState
    extends State<CurrentAddressSelectionButtonView> {
  Position? _userPosition;
  final List<Address> _nearbyAddresses = [];
  Address? _selectedAddress;

  void _onAddressSelection(Address _address) {
    setState(() {
      _selectedAddress = _address;
    });
    if (_selectedAddress != null && _userPosition != null) {
      widget._onCurrentAddressSelection.call(_userPosition!, _selectedAddress!);
    }
  }

  Future<void> _getUserPosition() async {
    _userPosition = await getUserLatLng(context);
    if (_userPosition != null) {
      _nearbyAddresses.clear();
      _nearbyAddresses.addAll(await getCurrentAddress(
          _userPosition!.latitude, _userPosition!.longitude));
      if (_selectedAddress == null) _onAddressSelection(_nearbyAddresses.first);
    }
  }

  Future<void> _openAddressSelectionScreen() async {
    final Address? _newAddress = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NearbyPlacesSelectionScreen(
          allAddresses: _nearbyAddresses,
        ),
      ),
    );
    if (_newAddress != null) {
      _onAddressSelection(_newAddress);
    }
  }

  @override
  void initState() {
    _getUserPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _openAddressSelectionScreen,
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        onPressed: () => _getUserPosition(),
        icon: SvgPicture.asset(
          'assets/icons/location.svg',
          color: _userPosition == null ? Colors.black : null,
        ),
      ),
      title: Text(_selectedAddress?.featureName ?? ''),
      subtitle: Text(_selectedAddress?.addressLine ?? ''),
    );
  }
}
