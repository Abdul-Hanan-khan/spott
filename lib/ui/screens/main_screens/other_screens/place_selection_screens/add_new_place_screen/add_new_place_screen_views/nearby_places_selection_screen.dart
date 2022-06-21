import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:spott/translations/codegen_loader.g.dart';

class NearbyPlacesSelectionScreen extends StatefulWidget {
  final List<Address> allAddresses;
  const NearbyPlacesSelectionScreen({
    required this.allAddresses,
    Key? key,
  }) : super(key: key);

  @override
  _NearbyPlacesSelectionScreenState createState() =>
      _NearbyPlacesSelectionScreenState();
}

class _NearbyPlacesSelectionScreenState
    extends State<NearbyPlacesSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.nearbyPlaces.tr(),
            style: const TextStyle(
              color: Colors.black,
            )
        ),
      ),
      body: ListView.separated(
        itemCount: widget.allAddresses.length,
        itemBuilder: (context, index) {
          return _buildListTitle(widget.allAddresses[index]);
        },
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }

  Widget _buildListTitle(Address _currentAddress) => ListTile(
        onTap: () => _onAddressTapped(_currentAddress),
        title: Text(_currentAddress.featureName ?? ''),
        subtitle: Text(_currentAddress.addressLine ?? ''),
      );

  void _onAddressTapped(Address _address) {
    Navigator.of(context).pop(_address);
  }
}
