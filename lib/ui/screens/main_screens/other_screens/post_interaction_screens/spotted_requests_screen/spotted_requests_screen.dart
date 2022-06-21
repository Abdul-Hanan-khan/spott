import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/blocs/feed_screen_cubits/spotted_request_screen_cubit/spotted_request_screen_cubit.dart';
import 'package:spott/models/data_models/spot.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/view_profile_screen/view_profile_screen.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/show_snack_bar.dart';

class SpottedRequestsScreen extends StatefulWidget {
  final int? postId;
  const SpottedRequestsScreen({Key? key, required this.postId})
      : super(key: key);

  @override
  _SpottedRequestsScreenState createState() => _SpottedRequestsScreenState();
}

class _SpottedRequestsScreenState extends State<SpottedRequestsScreen> {
  final List<Spot> _approvedSpots = [];
  final List<Spot> _pendingSpots = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SpottedRequestScreenCubit()..getAllSpottedRequests(widget.postId),
      child: BlocConsumer<SpottedRequestScreenCubit,
          SpottedRequestScreenCubitState>(
        listener: (context, state) {
          if (state is FailedToFetchSpottRequests && state.message != null) {
            showSnackBar(context: context, message: state.message!);
          }
          if (state is SpottedRequestsFetchedSuccessfully &&
              state.apiResponse.approvedSpots != null &&
              state.apiResponse.pendingSpots != null) {
            _approvedSpots.clear();
            _pendingSpots.clear();
            _approvedSpots.addAll(state.apiResponse.approvedSpots!);
            _pendingSpots.addAll(state.apiResponse.pendingSpots!);
          }
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading: state is FetchingSpottRequests,
            child: Scaffold(
              backgroundColor: AppColors.secondaryBackGroundColor,
              appBar: AppBar(
                title: Text(LocaleKeys.spotted.tr(),style: const TextStyle(
                  color: Colors.black,
                )),
              ),
              body: (state is SpottedRequestsFetchedSuccessfully &&
                      _approvedSpots.isEmpty &&
                      _pendingSpots.isEmpty)
                  ? _buildEmptyView()
                  : ListView.builder(
                      itemCount: _approvedSpots.length + _pendingSpots.length,
                      itemBuilder: (context, index) {
                        final Spot _spott = (index < _approvedSpots.length)
                            ? _approvedSpots[index]
                            : _pendingSpots[index - _approvedSpots.length];
                        return ListTile(
                          onTap: () => _openUserProfileScreen(_spott.user),
                          tileColor: Theme.of(context).scaffoldBackgroundColor,
                          title: Text(
                            _spott.user?.username ?? '',
                          ),
                          subtitle: Text(_spott.user?.name ?? ''),
                          leading: UserProfileImageView(_spott.user),
                          trailing: _approvedSpots.contains(_spott)
                              ? SvgPicture.asset(
                                  'assets/icons/eye_accepted.svg',
                                  height: 25,
                                )
                              : null,
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyView() {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          SvgPicture.asset('assets/icons/no_spotted.svg'),
          const SizedBox(
            height: 30,
          ),
          Text(
            LocaleKeys.noSpotted.tr(),
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenWidth / 10),
            child: Text(
              LocaleKeys.thereAreStillNoConfirmedSpotsInThisPlace.tr(),
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _openUserProfileScreen(User? _user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ViewProfileScreen(_user),
      ),
    );
  }
}
