import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/other_screens/place_detail_screen/place_detail_screen.dart';
import 'package:spott/ui/ui_components/count_text_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'loading_animation.dart';

class PlaceCardView extends StatelessWidget {
  final Place _place;
final int index;
  const PlaceCardView(
    this._place,
      this.index,{
    Key? key,
  }) : super(key: key);

  void _openDetailScreen(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PlaceDetailScreen(index,_place)));
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => _openDetailScreen(context),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, _screenWidth / 3.5, 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/building.svg",
                          color: CupertinoColors.systemGrey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _place.name ?? '',
                                style: Theme.of(context).textTheme.subtitle1,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                _place.fullAddress ?? '',
                                style: Theme.of(context).textTheme.bodyText1,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "FOLLOWING",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CountTextView(_place.followCount,
                                style: DefaultTextStyle.of(context).style),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            print("${_place.spotCount}");
                          },
                          child: Column(
                            children: [
                               Text(
                                LocaleKeys.spotted.tr().toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: AppColors.purple, fontSize: 12),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CountTextView(_place.spotCount,
                                  style: DefaultTextStyle.of(context).style),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                             Text(
                              LocaleKeys.rating.tr().toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              _place.averageRating?.toString() ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: DefaultTextStyle.of(context).style,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: _screenWidth / 3.5,
              height: _screenWidth / 3.5,
              child: (_place.images != null && _place.images!.isNotEmpty)
                  ? CachedNetworkImage(
                      imageUrl: _place.images?.first ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SizedBox(
                        width: _screenWidth / 3.5,
                        height: _screenWidth / 3.5,
                        child: const LoadingAnimation(),
                      ),
                      errorWidget: (context, url, error) => SizedBox(
                        width: _screenWidth / 3.5,
                        height: _screenWidth / 3.5,
                        child: const Icon(Icons.error),
                      ),
                    )
                  : Container(
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/icons/no_image.svg",
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
