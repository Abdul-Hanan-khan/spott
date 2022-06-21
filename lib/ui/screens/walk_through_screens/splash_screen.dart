import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spott/ui/screens/main_screens/main_screen.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    getUserLatLng(context).then((value) {
      setState(() {
        position = value;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    Timer(
        const Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => MainScreen())));

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
