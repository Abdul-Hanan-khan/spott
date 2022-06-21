import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/explore_screen_cubit/tabs/top_spots_cubit/top_sports_cubit.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/post_card_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/helper_functions.dart';

class TopSportsScreen extends StatefulWidget {
  const TopSportsScreen({Key? key}) : super(key: key);

  @override
  _TopSportsScreenState createState() => _TopSportsScreenState();
}

class _TopSportsScreenState extends State<TopSportsScreen> {
  ScrollController scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          loadMorePlaces(context);
        } else {}
      }
    });
  }

  Future<void> loadMorePlaces(BuildContext context) async {
    await getUserLatLng(context).then((value) {
      TopSpotsCubit().getTopSpots(
        context,
        AppData.accessToken.toString(),
        false,
      );
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {});
      });
    }).whenComplete(() {});
  }

  bool firstTimeLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (firstTimeLoading) {
      setupScrollController(context);
      setState(() {
        firstTimeLoading = false;
      });
    }
    return BlocProvider(
      create: (context) => TopSpotsCubit()..getTopSpots(context, AppData.accessToken.toString(), true),
      child: BlocConsumer<TopSpotsCubit, TopSpotsState>(
        listener: (context, state) {
          if (state is TopSpotsDataFetchedSuccessfully) {
            setState(() {});
          }
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading: state is TopSpotsFetchingData,
            child: Scaffold(
              backgroundColor: AppColors.secondaryBackGroundColor,
              body: RefreshIndicator(
                  onRefresh: () => _onRefresh(context),
                  child: (state is TopSpotsFailedToFetchData)
                      ? Center(
                          child: Text(state.msg),
                        )
                      : (state is TopSpotsDataFetchedSuccessfully)
                          ? ListView.separated(
                              controller: scrollController,
                              padding: const EdgeInsets.only(top: 10),
                              itemBuilder: (context, index) {
                                if (index <
                                    context
                                        .read<TopSpotsCubit>()
                                        .posts
                                        .length) {
                                  return PostCardView(index);
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 10);
                              },
                              itemCount:
                                  context.read<TopSpotsCubit>().posts.length +
                                      1,
                            )
                          : const SizedBox()),
            ),
          );
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<TopSpotsCubit>().refreshExploreData(context);
  }
}
