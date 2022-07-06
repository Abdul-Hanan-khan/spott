import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spott/blocs/activity_screen_cubit/activity_screen_cubit.dart';
import 'package:spott/blocs/spotted_list_view_cubit/spotted_list_view_cubit.dart';
import 'package:spott/resources/services/push_notification_service.dart';
import 'package:spott/ui/screens/walk_through_screens/splash_screen.dart';
import 'package:spott/ui/screens/walk_through_screens/start_walk_through_screen.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/preferences_controller.dart';

import 'blocs/feed_screen_cubits/feed_cubit/feed_cubit.dart';
import 'blocs/places_cubit/places_cubit.dart';
import 'blocs/post_card_view_cubit/post_card_view_cubit.dart';
import 'blocs/stories_cubits/view_stories_cubit/view_stories_cubit.dart';
import 'blocs/view_profile_screen_cubits/view_user_profile_cubit/view_user_profile_cubit.dart';
import 'resources/app_data.dart';
import 'ui/screens/walk_through_screens/start_walk_through_screen.dart';
import 'utils/preferences_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await EasyLocalization.ensureInitialized();
  AppData.setCameras(await availableCameras());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.green,
    ),
  );

  if (!PreferencesController.isNewUser()) {
    PushNotificationService();
  }

  final _supportedLocales = {
    'en',
    'it',
    'es',
    'fr',
    'pt',
  };

  final String _deviceLocale = Platform.localeName.split("_")[0];

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      startLocale: _supportedLocales.contains(_deviceLocale)
          ? Locale(_deviceLocale)
          : Locale(_supportedLocales.first),
      fallbackLocale: Locale(_supportedLocales.elementAt(1)),
      supportedLocales: _supportedLocales.map((e) => Locale(e)).toList(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<int, Color> primarySwatchColor = {
    50: AppColors.green.withOpacity(.1),
    100: AppColors.green.withOpacity(.2),
    200: AppColors.green.withOpacity(.3),
    300: AppColors.green.withOpacity(.4),
    400: AppColors.green.withOpacity(.5),
    500: AppColors.green.withOpacity(.6),
    600: AppColors.green.withOpacity(.7),
    700: AppColors.green.withOpacity(.8),
    800: AppColors.green.withOpacity(.9),
    900: AppColors.green.withOpacity(1),
  };

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeedCubit(),
        ),
        BlocProvider<PostCardViewCubit>(
          create: (BuildContext context) => PostCardViewCubit(),
        ),
        BlocProvider<PlacesCubit>(
          create: (BuildContext context) => PlacesCubit(),
        ),
        BlocProvider<ActivityScreenCubit>(
          create: (BuildContext context) => ActivityScreenCubit(),
        ),
        BlocProvider<ViewStoriesCubit>(
          create: (context) => ViewStoriesCubit(),
        ),
        BlocProvider<ViewUserProfileCubit>(
          create: (context) => ViewUserProfileCubit(),
        ),
        BlocProvider<SpottedListViewCubit>(
          create: (context) => SpottedListViewCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Spott',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: 'SFUI',
          primaryColor: AppColors.green,
          primarySwatch:
              MaterialColor(AppColors.green.value, primarySwatchColor),
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(errorMaxLines: 2),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
            titleTextStyle:
                TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          ),
        ),
        home: PreferencesController.isNewUser()
            ? const StartWalkThroughScreen()
            : const SplashScreen(),
      ),
    );
  }
}

//! cmd to run after adding new text in translation json files:
// import 'package:easy_localization/easy_localization.dart';
//! flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" - o "locale_keys.g.dart" -f keys
