import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/search_cubit/search_cubit.dart';
import 'package:spott/models/api_responses/search_api_response.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/other_screens/place_detail_screen/place_detail_screen.dart';
import 'package:spott/ui/screens/main_screens/view_profile_screen/view_profile_screen.dart';
import 'package:spott/ui/ui_components/app_tab_bar.dart';
import 'package:spott/ui/ui_components/app_text_field.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/place_image_view.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/show_snack_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  SearchApiResponse? _apiResponse;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchCubitState>(
        listener: (context, state) {
          if (state is FailedToSearch) {
            showSnackBar(context: context, message: state.message);
          } else if (state is SearchedSuccessfully) {
            _apiResponse = state.apiResponse;
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.secondaryBackGroundColor,
            appBar: AppBar(
              title: AppTextField(
                hintText: LocaleKeys.search.tr(),
                autofocus: true,
                onChanged: (value) => _onSearchFiledChange(context, value),
                backGroundColor: AppColors.secondaryBackGroundColor,
                icon: const Icon(Icons.search),
                borderRadius: BorderRadius.circular(10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                textInputAction: TextInputAction.search,
                onSubmit: (value) => _onSearchSubmit(context, value),
              ),
              bottom: _apiResponse != null
                  ? AppTabBar(
                      _tabController,
                      labels: [
                        LocaleKeys.all.tr(),
                        LocaleKeys.users.tr(),
                        LocaleKeys.places.tr()
                      ],
                    )
                  : null,
            ),
            body: LoadingScreenView(
              isLoading: state is Searching,
              child: _apiResponse != null
                  ? TabBarView(
                      controller: _tabController,
                      children: [
                        _buildResultsListView(
                            users: _apiResponse?.users,
                            places: _apiResponse?.places),
                        _buildResultsListView(
                          users: _apiResponse?.users,
                        ),
                        _buildResultsListView(places: _apiResponse?.places),
                      ],
                    )
                  : const SizedBox(),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget _buildPlaceListTile(Place? _place) => _place != null
      ? ListTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlaceDetailScreen(0,_place),
            ),
          ),
          leading: PlaceImageView(_place.images?.firstOrNull),
          title: Text(_place.name ?? '',
              maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(
            _place.fullAddress ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      : const SizedBox();

  Widget _buildResultsListView({List<User>? users, List<Place>? places}) =>
      ListView.separated(
        itemCount: (users?.length ?? 0) + (places?.length ?? 0),
        itemBuilder: (context, index) {
          if (index < (users?.length ?? 0)) {
            return _buildUserListTile(users?.elementAt(index));
          } else {
            return _buildPlaceListTile(
                places?.elementAt(index - (users?.length ?? 0)));
          }
        },
        separatorBuilder: (_, __) => const Divider(),
      );

  Widget _buildUserListTile(User? _user) => _user != null
      ? ListTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ViewProfileScreen(_user),
            ),
          ),
          leading: UserProfileImageView(
            _user,
          ),
          title: Text(_user.name ?? '',
              maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(_user.username ?? '',
              maxLines: 1, overflow: TextOverflow.ellipsis),
        )
      : const SizedBox();

  void _onSearchFiledChange(BuildContext context, String value) {
    if (value.length > 2) {
      _search(context, value);
    }
  }

  void _onSearchSubmit(BuildContext context, String value) {
    _search(context, value);
  }

  void _search(BuildContext context, String value) {
    context.read<SearchCubit>().search(value);
  }
}
