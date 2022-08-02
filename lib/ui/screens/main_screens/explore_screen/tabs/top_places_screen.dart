import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/authentication_cubits/reset_password_cubit/reset_password_cubit.dart';
import 'package:spott/blocs/explore_screen_cubit/tabs/top_places_cubit/top_places_cubit.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/place_card_view.dart';
import 'package:spott/ui/ui_components/post_card_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/helper_functions.dart';

class TopPlacesScreen extends StatefulWidget {
  const TopPlacesScreen({Key? key}) : super(key: key);

  @override
  _TopPlacesScreenState createState() => _TopPlacesScreenState();
}

class _TopPlacesScreenState extends State<TopPlacesScreen> {
  ScrollController scrollController = ScrollController();
  bool dataIsFetching = false;
  setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          setState(() {
            dataIsFetching = true;
          });
          loadMorePlaces(context);
          Future.delayed(Duration(milliseconds: 400), () {
            setState(() {});
          });
        } else {}
      }
    });
  }

  Future<void> loadMorePlaces(BuildContext context) async {
    await getUserLatLng(context).then((value) {
      TopPlacesCubit().getTopPlaces(
        context,
        AppData.accessToken.toString(),
        false,
      );
    }).whenComplete(() {});
  }

  bool firstTimeLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (firstTimeLoading) {
      setupScrollController(context);
      setState(() {
        firstTimeLoading = false;
      });
    }
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => TopPlacesCubit()
        ..getTopPlaces(context, AppData.accessToken.toString(), true),
      child: BlocConsumer<TopPlacesCubit, TopPlacesState>(
        listener: (context, state) {
          if (state is TopPlacesDataFetchedSuccessfully) {
            setState(() {});
          }
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading: state is TopPlacesFetchingData ||
                state is TopPlacesRefreshingData,
            child: Scaffold(
              backgroundColor: AppColors.secondaryBackGroundColor,
              body: RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: (state is TopPlacesFailedToFetchData)
                    ? Center(
                        child: Text(state.msg),
                      )
                    : (state is TopPlacesDataFetchedSuccessfully)
                        ? context.read<TopPlacesCubit>().places.length == 0 || (context.read<TopPlacesCubit>().places.length ==null)
                            ? Center(
                                child: Text(LocaleKeys.placeNotAvailable.tr(),style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: size.width*0.04,
                                ),),
                              )
                            : ListView.separated(
                                controller: scrollController,
                                padding: const EdgeInsets.only(top: 10),
                                itemBuilder: (context, index) {
                                  if (index <
                                      context
                                          .read<TopPlacesCubit>()
                                          .places
                                          .length) {
                                    return PlaceCardView(
                                      context
                                          .read<TopPlacesCubit>()
                                          .places
                                          .elementAt(index),
                                      index
                                    );
                                  } else {
                                    Future.delayed(
                                        const Duration(
                                          milliseconds: 30,
                                        ), () {
                                      scrollController.jumpTo(scrollController
                                          .position.maxScrollExtent);
                                    });
                                    return Container(
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  }
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 10);
                                },
                                itemCount: (context
                                        .read<TopPlacesCubit>()
                                        .places
                                        .length +
                                    1),
                              )
                        : const SizedBox(),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<TopPlacesCubit>().refreshExploreData(context);
  }
}
