import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share/share.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/preferences_controller.dart';
import 'package:spott/utils/show_snack_bar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

Future<List<Address>> getCurrentAddress(double _lat, double _lng) =>
    Geocoder.local.findAddressesFromCoordinates(Coordinates(_lat, _lng));

Map<String,dynamic> getStringFromTime(DateTime? time) {
  if (time != null) {
    var timeagooo=timeago.format(time, locale: 'en_short');

    var postTime= timeagooo.replaceAll(RegExp(r'[^0-9]'), '');
    var postTimeSymbol= timeagooo.replaceAll(RegExp(r'[^a-z]'), '');

    print(postTime);
    print(postTimeSymbol);

    Map<String,dynamic> timeStamp=({
      'postTime': postTime,
      'postSymbol':postTimeSymbol
    });

print(timeStamp);

    print(timeagooo);
    return timeStamp;
  } else {
    return ({});
  }
}

Future<Position?> getUserLatLng(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();// error occurs like firebase
  if (!serviceEnabled) {
    // Location services are disabled.
    showSnackBar(
        context: context, message: LocaleKeys.locationServicesDisabled.tr());
    return PreferencesController.getUserLocation();
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Location permissions are denied
      showSnackBar(
          context: context, message: LocaleKeys.allowLocationPermission.tr());
      return PreferencesController.getUserLocation();
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Location permissions are permanently denied, we cannot request permissions.
    showSnackBar(
        context: context, message: LocaleKeys.allowLocationPermission.tr());
    return PreferencesController.getUserLocation();
  }
  final Position _position = await Geolocator.getCurrentPosition();
  PreferencesController.saveUserLocation(_position);
  return _position;
}

bool isEmailValid(String email) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email);

bool isNotCurrentUser(int? id) {
  return id != null && AppData.currentUser?.id != id;
}

Future<void> openUrl(String _url) async {
  try {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  } catch (e) {
    throw 'Could not launch $_url';
  }
}

void sharePlaceLink(String link) {
  Share.share('Check this place on Spott@ $link', subject: 'Hi, Join Spott@');
}

void shareUserProfileLink(String link) {
  Share.share('Check this profile on Spott@ $link', subject: 'Hi, Join Spott@');
}
