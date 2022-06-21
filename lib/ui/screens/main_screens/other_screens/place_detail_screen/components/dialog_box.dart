import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/blocs/place_detail_screen_cubit/rating_cubit/rating_cubit.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/show_snack_bar.dart';

class CustomDialogBox extends StatefulWidget {
  final String? placeId;
  const CustomDialogBox({Key? key, required this.placeId}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  String rating = '';
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => RatingCubit(),
      child: BlocConsumer<RatingCubit, RatingState>(
        listener: (context, state) {
          if (state is RatingSuccess) {
            showSnackBar(context: context, message: state.msg.toString());
            Navigator.pop(context);
          } else if (state is RatingFailed) {
            // showSnackBar(context: context, message: 'Network problem');
          }
        },
        builder: (context, state) {
          return Container(
            width: size.width,
            height: size.height * 0.33,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40), color: Colors.white),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('assets/icons/cancel.svg'),
                    )
                  ],
                ),
                Text(
                  "Rate this place",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * 0.065,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.03, left: size.width * 0.03),
                    width: size.width,
                    child: RatingBar.builder(
                      initialRating: 3,
                      itemSize: size.width * 0.09,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: AppColors.green,
                      ),
                      onRatingUpdate: (rat) {
                            setState(() {
                              rating = rat.toString();
                            });
                      },
                    )

                    // RatingBar(
                    //   itemSize: size.width*0.097,
                    //   allowHalfRating: false,
                    //   minRating: 1.0,
                    //   maxRating: 5,
                    //   direction: Axis.horizontal,
                    //   ratingWidget: RatingWidget(
                    //     full: SvgPicture.asset('assets/icons/green_star.svg'),
                    //     empty: SvgPicture.asset('assets/icons/grey_star.svg'),
                    //     half: SvgPicture.asset('assets/icons/grey_star.svg'),
                    //   ),
                    //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    //   onRatingUpdate: (rat) {
                    //     setState(() {
                    //       rating = rat.toString();
                    //     });
                    //   },
                    // ),
                    ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Write your review',
                  ),
                ),
                if (state is RatingLoading)
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(top: size.height * 0.034),
                      alignment: Alignment.center,
                      width: size.width * 0.35,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text(
                        'wait..',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                if (state is! RatingLoading)
                  InkWell(
                    onTap: () {
                      if (_controller.text.isNotEmpty && rating.length > 1) {
                        context.read<RatingCubit>().placeRating(
                            _controller.text,
                            rating,
                            widget.placeId.toString(),
                            AppData.accessToken.toString());
                      } else {
                        showSnackBar(
                          context: context,
                          message: 'Rating or review is missing',
                        );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: size.height * 0.034),
                      alignment: Alignment.center,
                      width: size.width * 0.65,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: AppColors.greenGradient
                      ),
                      child:  Text(
                        LocaleKeys.ok.tr(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
