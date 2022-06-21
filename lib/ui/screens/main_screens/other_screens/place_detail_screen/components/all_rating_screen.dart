import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/blocs/place_detail_screen_cubit/all_rating_cubit/all_rating_cubit.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/translations/codegen_loader.g.dart';

class AllRatingScreen extends StatefulWidget {
  final String? placeId;
  const AllRatingScreen({Key? key, required this.placeId}) : super(key: key);

  @override
  _AllRatingScreenState createState() => _AllRatingScreenState();
}

class _AllRatingScreenState extends State<AllRatingScreen> {
  @override
  void initState() {
    super.initState();
    // print("place id ${widget.placeId}");
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AllRatingCubit()
        ..getAllRatings(
          widget.placeId.toString(),
          AppData.accessToken.toString(),
        ),
      child: BlocConsumer<AllRatingCubit, AllRatingState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AllRatingLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AllRatingSuccessState) {
            return SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    centerTitle: false,
                    title: Text(
                      LocaleKeys.reviews.tr(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    elevation: 1,
                  ),
                  body: Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: ListView.builder(
                        itemCount:
                            state.allRatingApiResponseModel.ratings!.length,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: const Offset(1, 1),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                    )
                                  ]),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${state.allRatingApiResponseModel.ratings![index].place!.name}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  RatingBarIndicator(
                                    rating: double.parse(state
                                        .allRatingApiResponseModel
                                        .ratings![index]
                                        .rating
                                        .toString()),
                                    itemBuilder: (context, index) =>
                                        SvgPicture.asset(
                                            'assets/icons/green_favorite.svg'),
                                    itemCount: 5,
                                    itemSize: size.width * 0.1,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    direction: Axis.horizontal,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Text(state.allRatingApiResponseModel
                                      .ratings![index].comment
                                      .toString())
                                ],
                              ));
                        }),
                  )),
            );
          }
          if (state is AllRatingFailedState) {
            return Container(
              alignment: Alignment.center,
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(color: Colors.white),
              child: Center(
                child: Text('${state.allRatingApiResponseModel.message}'),
              ),
            );
          }
          return Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(color: Colors.white),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
