import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spott/blocs/feed_screen_cubits/feed_cubit/feed_cubit.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/main_screen.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/variables.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import '../../../utils/show_snack_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // getUserLatLng(context).then((value) {
    //   setState(() {
    //     position = value;
    //   });
    // });
    _getInitialData(context);

    super.initState();
  }
  bool locationIsOn = true;

  void _getInitialData(BuildContext context) async {
    final bool isAccepted = await checkLocationPermission();

    if (isAccepted) {
      setState(() {
        locationIsOn = true;
      });

      await getUserLatLng(context).then((value) {
        if (value != null && value.longitude != null) {
          context.read<FeedCubit>().getAllData(position: value);
        } else {
          showSnackBar(context: context, message: LocaleKeys.pleaseTurnOnYourLocation.tr());
        }
      }).whenComplete(() {});
    } else {
      setState(() {
        locationIsOn = false;
      });
    }
  }

  Future<bool> checkLocationPermission() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();

    if (_serviceEnabled) {
      return true;
    } else {
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    Timer(
        const Duration(seconds: 5),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => MainScreen(true))));

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset('assets/images/app_icon.png'),
              ),
            ),
            const Divider(
              height: 0,
            ),
          ],
        ),
      ),
    );
  }
}
