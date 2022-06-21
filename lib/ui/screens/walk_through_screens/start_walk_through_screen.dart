import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/walk_through_screens/walk_through_screen.dart';

class StartWalkThroughScreen extends StatefulWidget {
  const StartWalkThroughScreen({Key? key}) : super(key: key);

  @override
  _StartWalkThroughScreenState createState() => _StartWalkThroughScreenState();
}

class _StartWalkThroughScreenState extends State<StartWalkThroughScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            InkWell(
              onTap: _onStartPressed,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 50,
                ),
                child: Center(
                  child: Text(
                    LocaleKeys.start.tr(),style: TextStyle(
                    fontSize: size.width * 0.06
                  ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onStartPressed() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const WalkThroughScreen(),
      ),
    );
  }
}
