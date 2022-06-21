import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spott/blocs/settings_cubits/settings_screen_cubit/settings_screen_cubit.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/models/data_models/user_preferences.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/authentication_screens/login_screen.dart';
import 'package:spott/ui/screens/main_screens/other_screens/setting_screen/language_selection_view/language_selection_view.dart';
import 'package:spott/ui/screens/main_screens/other_screens/setting_screen/view_blocked_users_screen/view_blocked_users_screen.dart';
import 'package:spott/ui/ui_components/error_view.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/spott_dialog_boxes.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';
import 'change_password_screen/change_password_screen.dart';
import 'edit_profile_screen/edit_profile_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class __FormRowWithSliderState extends State<_FormRowWithSlider> {
  late double _value;

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "50M",
                  style: _value != 50
                      ? null
                      : const TextStyle(color: AppColors.green),
                ),
                Text(
                  "2500M",
                  style: _value != 2500
                      ? null
                      : const TextStyle(color: AppColors.green),
                ),
                Text(
                  "5000M",
                  style: _value != 5000
                      ? null
                      : const TextStyle(color: AppColors.green),
                ),
              ],
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.grey[300],
              inactiveTrackColor: Colors.grey[300],
              trackHeight: 3.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
              overlayColor: Colors.green.withAlpha(32),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
            ),
            child: Slider(
              min: 50,
              max: 5000,
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
                widget.onChanged(_value);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }
}

class _FormRowWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool showIcon;
  final Color? textColor;
  final GestureTapCallback onTap;

  const _FormRowWithIcon(
      {Key? key,
      required this.text,
      required this.onTap,
      this.icon = Icons.navigate_next,
      this.showIcon = true,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: CupertinoFormRow(
        padding: const EdgeInsets.all(20),
        prefix: Text(
          text,
          style:
              Theme.of(context).textTheme.subtitle1!.copyWith(color: textColor),
        ),
        child: showIcon ? Icon(icon) : const SizedBox(),
      ),
    );
  }
}

class _FormRowWithSlider extends StatefulWidget {
  final Function(double) onChanged;
  final double initialValue;

  const _FormRowWithSlider(
      {Key? key, required this.onChanged, required this.initialValue})
      : super(key: key);

  @override
  __FormRowWithSliderState createState() => __FormRowWithSliderState();
}

class _FormRowWithSwitchView extends StatefulWidget {
  final String text;
  final bool initialValue;
  final Function(bool) onChanged;

  const _FormRowWithSwitchView(
      {Key? key,
      required this.text,
      required this.initialValue,
      required this.onChanged})
      : super(key: key);

  @override
  _FormRowWithSwitchViewState createState() => _FormRowWithSwitchViewState();
}

class _FormRowWithSwitchViewState extends State<_FormRowWithSwitchView> {
  bool toggleValue = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      padding: const EdgeInsets.all(20),
      prefix: Text(
        widget.text,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      child: CupertinoSwitch(
        value: toggleValue,
        onChanged: (value) {
          setState(() {
            toggleValue = value;
          });
          widget.onChanged(toggleValue);
        },
      ),
    );
  }

  @override
  void initState() {
    toggleValue = widget.initialValue;
    super.initState();
  }
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isNotificationEnabled = true;
  bool _isEmailNotificationEnabled = true;
  bool _isChatNotificationEnabled = true;
  bool _isNearbySpotNotificationEnabled = true;
  bool _isPrivateProfileEnabled = false;
  double _sliderValue = 2500;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsScreenCubit()..getUserPreferences(),
      child: BlocConsumer<SettingsScreenCubit, SettingsScreenState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showSnackBar(context: context, message: state.message);
          } else if (state is FetchedUserPreferencesSuccessfully) {
            _setUserPreferences(state.userPreferences);
          } else if (state is SignOutUser) {
            if (state.errorMessage != null) {
              showSnackBar(context: context, message: state.errorMessage!);
            }
            _navigateUserToLoginScreen(context);
          }
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading:
                state is FetchingUserPreferences || state is SignOutingUser,
            child: Scaffold(
              backgroundColor: AppColors.secondaryBackGroundColor,
              appBar: AppBar(
                title: Text(LocaleKeys.settings.tr(),
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500)),
              ),
              body: (state is ErrorState)
                  ? ErrorView(
                      onRetryPressed: () => _onRetryButtonPressed(context),
                    )
                  : (state is FetchingUserPreferences)
                      ? const SizedBox()
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              //notifications
                              CupertinoFormSection(
                                header: Text(LocaleKeys.notifications.tr()),
                                children: <Widget>[
                                  _FormRowWithSwitchView(
                                    initialValue: _isNotificationEnabled,
                                    onChanged: (value) =>
                                        _onNotificationChanged(context, value),
                                    text: LocaleKeys.notifications.tr(),
                                  ),
                                  _FormRowWithSwitchView(
                                      initialValue: _isEmailNotificationEnabled,
                                      onChanged: (value) =>
                                          _onEmailNotificationChanged(
                                              context, value),
                                      text: LocaleKeys.emailNotifications.tr()),
                                  _FormRowWithSwitchView(
                                      initialValue: _isChatNotificationEnabled,
                                      onChanged: (value) =>
                                          _onChatNotificationChanged(
                                              context, value),
                                      text: LocaleKeys.chatNotifications.tr()),
                                  _FormRowWithSwitchView(
                                      initialValue:
                                          _isNearbySpotNotificationEnabled,
                                      onChanged: (value) =>
                                          _onNearbySpotNotificationChanged(
                                              context, value),
                                      text: LocaleKeys.nearbySpotNotifications
                                          .tr()),
                                  _FormRowWithSlider(
                                    initialValue: _sliderValue,
                                    onChanged: (value) =>
                                        _onSliderMove(context, value),
                                  )
                                ],
                              ),

                              //user Settings
                              CupertinoFormSection(
                                header: Text(LocaleKeys.userSettings.tr()),
                                children: <Widget>[
                                  _FormRowWithSwitchView(
                                    initialValue: _isPrivateProfileEnabled,
                                    onChanged: (value) =>
                                        _onPrivateProfileEnabled(
                                            context, value),
                                    text: LocaleKeys.privateProfile.tr(),
                                  ),
                                  _FormRowWithIcon(
                                    text: LocaleKeys.editProfile.tr(),
                                    onTap: _openEditProfileScreen,
                                  ),
                                  _FormRowWithIcon(
                                    text: LocaleKeys.changePassword.tr(),
                                    onTap: _openChangePasswordScreen,
                                  ),
                                  _FormRowWithIcon(
                                    text: LocaleKeys.blockedUsers.tr(),
                                    onTap: _openViewBlockedUsersScreen,
                                  ),
                                ],
                              ),

                              //User settings
                              CupertinoFormSection(
                                header: Text(LocaleKeys.appSetting.tr()),
                                children: <Widget>[
                                  _FormRowWithIcon(
                                    text: LocaleKeys.spottedGuide.tr(),
                                    onTap: () =>
                                        showSendSpottRequestDialogBox(context),
                                  ),
                                  _FormRowWithIcon(
                                    text: LocaleKeys.languages.tr(),
                                    onTap: _openLanguageSelectionView,
                                  ),
                                  _FormRowWithIcon(
                                    text: LocaleKeys.helpCenter.tr(),
                                    onTap: _openHelpCenterUrl,
                                  ),
                                  _FormRowWithIcon(
                                    text: LocaleKeys.shareApp.tr(),
                                    onTap: () {},
                                    icon: Icons.share,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              CupertinoFormSection(
                                children: <Widget>[
                                  _FormRowWithIcon(
                                    text: LocaleKeys.logout.tr(),
                                    onTap: () =>
                                        _onLogoutButtonPressed(context),
                                    showIcon: false,
                                    textColor: Colors.red,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        ),
            ),
          );
        },
      ),
    );
  }

  void _navigateUserToLoginScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (Route<dynamic> route) => false);
  }

  void _onChatNotificationChanged(BuildContext context, bool newValue) {
    _isChatNotificationEnabled = newValue;
    _updateUserPreferences(context);
  }

  void _onEmailNotificationChanged(BuildContext context, bool newValue) {
    _isEmailNotificationEnabled = newValue;
    _updateUserPreferences(context);
  }

  void _onLogoutButtonPressed(BuildContext context) {
    context.read<SettingsScreenCubit>().logOutUser();
    if (GoogleSignIn().currentUser?.email != null) {
      GoogleSignIn().signOut();
    }
  }

  void _onNearbySpotNotificationChanged(BuildContext context, bool newValue) {
    _isNearbySpotNotificationEnabled = newValue;
    _updateUserPreferences(context);
  }

  void _onNotificationChanged(BuildContext context, bool newValue) {
    _isNotificationEnabled = newValue;
    _updateUserPreferences(context);
  }

  void _onPrivateProfileEnabled(BuildContext context, bool newValue) {
    _isPrivateProfileEnabled = newValue;
    _updateUserPreferences(context);
  }

  void _onRetryButtonPressed(BuildContext context) {
    context.read<SettingsScreenCubit>().getUserPreferences();
  }

  void _onSliderMove(BuildContext context, double value) {
    _sliderValue = value;
    _updateUserPreferences(context);
  }

  void _openChangePasswordScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChangePasswordScreen(),
      ),
    );
  }

  void _openEditProfileScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
      ),
    );
  }

  void _openHelpCenterUrl() {
    openUrl('https://helpcenter.spottat.com');
  }

  void _openLanguageSelectionView() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) => const LanguageSelectionView());
  }

  void _openViewBlockedUsersScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ViewBlockedUsersScreen()));
  }

  void _setUserPreferences(UserPreferences _preferences) {
    _isNotificationEnabled =
        _preferences.isNotifications ?? _isNotificationEnabled;
    _isEmailNotificationEnabled =
        _preferences.emailNotifications ?? _isEmailNotificationEnabled;
    _isChatNotificationEnabled =
        _preferences.chatNotifications ?? _isChatNotificationEnabled;
    _isNearbySpotNotificationEnabled = _preferences.nearbySpotNotifications ??
        _isNearbySpotNotificationEnabled;
    _isPrivateProfileEnabled = _preferences.profileType == ProfileType.private;
    _sliderValue = _preferences.radius ?? _sliderValue;
  }

  void _updateUserPreferences(BuildContext context) {
    context.read<SettingsScreenCubit>().updateUserPreferences(UserPreferences(
          isNotifications: _isNotificationEnabled,
          emailNotifications: _isEmailNotificationEnabled,
          chatNotifications: _isChatNotificationEnabled,
          nearbySpotNotifications: _isNearbySpotNotificationEnabled,
          profileType: _isPrivateProfileEnabled
              ? ProfileType.private
              : ProfileType.public,
          radius: _sliderValue,
          language: 'en',
        ));
  }
}
