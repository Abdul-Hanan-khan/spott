import 'package:app_settings/app_settings.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spott/resources/services/push_notification_service.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/authentication_screens/login_screen.dart';
import 'package:spott/utils/constants/app_colors.dart';

class WalkThroughPage extends StatelessWidget {
  final String image;
  final String? tile;
  final String? description;
  final Widget? customTitle;
  final bool? isSVG;

  const WalkThroughPage(
      {required this.image,
      this.tile,
      this.description,
      this.customTitle,
      Key? key,
      this.isSVG})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (isSVG == true)
          SvgPicture.asset(
            image,
            // height: MediaQuery.of(context).size.height * 0.9,
            width: double.infinity,
          ),
        if (isSVG == false)
          Image.asset(
            image,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.93,
            width: double.infinity,
          ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (customTitle != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: customTitle,
                ),
              if (tile != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    tile ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              if (description != null)
                Text(
                  description ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  final PageController _pageController = PageController();
  PermissionStatus? _locationPermissionStatus;
  PermissionStatus? _notificationsPermissionStatus;

  final ValueNotifier<double> notifier = ValueNotifier(0);
  late List<Widget> _pages;

  final Duration _pageAnimationDuration = const Duration(milliseconds: 300);

  int _currentPage = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [

            Container(
              height:MediaQuery.of(context).size.height * 0.93,
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, index) => _pages[index]),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: _onBackButtonPressed,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 50),
                      child: Center(
                        child: Text(
                          LocaleKeys.back.tr(),
                        ),
                      ),
                    ),
                  ),
                  DotsIndicator(
                    dotsCount: _pages.length,
                    position: _currentPage.toDouble(),
                    decorator: const DotsDecorator(
                      color: CupertinoColors.systemGrey4, // Inactive color
                      activeColor: AppColors.green,
                    ),
                  ),
                  GestureDetector(
                    onTap: _onNextButtonPressed,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 50),
                      child: Center(
                        child: Text(
                          LocaleKeys.next.tr(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ));
  }

  @override
  void initState() {
    _checkInitialGrantedPermissions();
    _pages = _generatePages();
    super.initState();
  }

  void _askForLocationPermission(Function _onGranted) {
    if (_locationPermissionStatus == null) {
      _checkInitialGrantedPermissions();
    } else if (_locationPermissionStatus != PermissionStatus.granted) {
      Permission.location.request().then((value) {
        if (value == PermissionStatus.granted) {
          PushNotificationService();
          _onGranted();
        }
        if (value == PermissionStatus.permanentlyDenied) {
          AppSettings.openLocationSettings();
        }
      });
    } else {
      _onGranted();
    }
  }

  Future<void> _checkInitialGrantedPermissions() async {
    _locationPermissionStatus = await Permission.location.status;
    _notificationsPermissionStatus = await Permission.notification.status;
  }

  List<Widget> _generatePages() => [
        WalkThroughPage(
          isSVG: false,
          image: 'assets/images/one.jpg',
        ),
        WalkThroughPage(
          isSVG: false,
          image: 'assets/images/two.jpg',
        ),
        WalkThroughPage(
          isSVG: false,
          image: 'assets/images/three.jpg',
        ),
        WalkThroughPage(
          isSVG: false,
          image: 'assets/images/four.jpg',
        ),
        WalkThroughPage(
          isSVG: false,
          image: 'assets/images/five.gif',
        ),
        WalkThroughPage(
          isSVG: false,
          image: 'assets/images/six.jpg',
        ),
      ];

  void _moveToNextWalkThroughPage() {
    _currentPage += 1;
    _pageController.animateToPage(_currentPage.round(),
        duration: _pageAnimationDuration, curve: Curves.linear);
    setState(() {});
  }

  void _navigateToLoginScreen() {
    _askForLocationPermission((){
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      });
    });

  }

  void _onBackButtonPressed() {
    if (_currentPage != 0) {
      _currentPage -= 1;
      _pageController.animateToPage(_currentPage.round(),
          duration: _pageAnimationDuration, curve: Curves.linear);
      setState(() {});
    }
  }

  void _onNextButtonPressed() {
    // if (_currentPage == 6) {
    //   _askForLocationPermission(_moveToNextWalkThroughPage);
    // } else
      if (_currentPage < _pages.length - 1) {
      _moveToNextWalkThroughPage();
    } else {
      //!last next button pressed
      if (_notificationsPermissionStatus == null) {
        _checkInitialGrantedPermissions();
      } else if (_notificationsPermissionStatus != PermissionStatus.granted) {
        Permission.notification.request().then((value) {
          if (value == PermissionStatus.granted) {
            _navigateToLoginScreen();
          }
          if (value == PermissionStatus.permanentlyDenied) {
            AppSettings.openNotificationSettings();
          }
        });
      } else {
        _navigateToLoginScreen();
      }
    }
  }

  void _onPageChanged(int _page) {
    // if (_page == 5) {
    //   _askForLocationPermission(() {
    //     setState(() {
    //       _currentPage = _page;
    //     });
    //   });
      if (_currentPage != _page) {
        _pageController.jumpToPage(_currentPage);
      // }
    } else {
      setState(() {
        _currentPage = _page;
      });
    }
  }
}
