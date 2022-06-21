import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spott/blocs/explore_screen_cubit/explore_screen_cubit.dart';
import 'package:spott/models/api_responses/get_explore_api_response.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/explore_screen/tabs/top_places_screen.dart';
import 'package:spott/ui/screens/main_screens/explore_screen/tabs/top_spots_screen.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/app_tab_bar.dart';
import 'package:spott/ui/ui_components/error_view.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/place_card_view.dart';
import 'package:spott/ui/ui_components/post_card_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/show_snack_bar.dart';

import 'search_screen/search_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  Completer<void>? _refreshCompleter;
  GetExploreApiResponse? _apiResponse;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => ExploreScreenCubit(),
      child: BlocConsumer<ExploreScreenCubit, ExploreScreenState>(
        listener: (context, state) {
          if (state is FailedToFetchData) {
            showSnackBar(context: context, message: state.message);
            _stopPullToRefreshLoader();
          } else if (state is DataFetchedSuccessfully) {
            _stopPullToRefreshLoader();
            _apiResponse = state.apiResponse;
          }
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading: false,
            child: Scaffold(
              backgroundColor: AppColors.secondaryBackGroundColor,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: _openSearchScreen,
                  icon: const Icon(Icons.search),
                ),
                title: Text(
                  LocaleKeys.explore.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                bottom: AppTabBar(
                  _tabController,
                  labels: [
                    LocaleKeys.topSpots.tr(),
                    LocaleKeys.trendingPlaces.tr(),
                  ],
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: const <Widget>[TopSportsScreen(), TopPlacesScreen()],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  Widget _buildNoGpsLocationView(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          SvgPicture.asset('assets/icons/no_gps_location.svg'),
          const SizedBox(
            height: 30,
          ),
          Text(
            LocaleKeys.noGPSConnection.tr(),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.045),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenWidth / 10),
            child: Text(
              LocaleKeys.pleaseCheckForLocationPermission.tr(),
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenWidth / 8),
            child: AppButton(
              text: LocaleKeys.retry.tr(),
              onPressed: () => _onRetryButtonPressed(context),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildPlacesListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: (_apiResponse?.topPlaces != null)
          ? ListView.separated(
              padding: const EdgeInsets.only(top: 10),
              itemCount: _apiResponse!.topPlaces!.length,
              itemBuilder: (context, index) {
                return PlaceCardView(_apiResponse!.topPlaces![index],index);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
            )
          : const SizedBox(),
    );
  }

  Widget _buildPostListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: (_apiResponse?.topSpots != null)
          ? ListView.separated(
              padding: const EdgeInsets.only(top: 10),
              itemCount: _apiResponse!.topSpots!.length,
              itemBuilder: (context, index) {
                return PostCardView(index);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
            )
          : const SizedBox(),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ExploreScreenCubit>().refreshExploreData(context);
    return _refreshCompleter?.future;
  }

  void _onRetryButtonPressed(BuildContext context) {
    context.read<ExploreScreenCubit>().getInitialExploreData(context);
  }

  void _openSearchScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      ),
    );
  }

  void _stopPullToRefreshLoader() {
    _refreshCompleter?.complete();
    _refreshCompleter = Completer();
  }
}
