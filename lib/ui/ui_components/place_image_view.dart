import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlaceImageView extends StatelessWidget {
  final String? _imageUrl;
  final double size;
  const PlaceImageView(
    this._imageUrl, {
    Key? key,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: _imageUrl != null
          ? CachedNetworkImage(
              imageUrl: _imageUrl!,
              height: size,
              width: size,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => SvgPicture.asset(
                'assets/icons/place_default_image.svg',
                height: size,
                width: size,
              ),
            )
          : SvgPicture.asset(
              'assets/icons/place_default_image.svg',
              height: size,
              width: size,
            ),
    );
  }
}
