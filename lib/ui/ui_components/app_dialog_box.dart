import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class AppDialogBox extends StatelessWidget {
  final String? image;
  final Widget title;
  final Widget description;
  final Widget button;

  const AppDialogBox({
    Key? key,
    required this.title,
    required this.description,
    this.image,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SvgPicture.asset(image!),
                ),
              title,
              const SizedBox(
                height: 20,
              ),
              description,
              const SizedBox(
                height: 20,
              ),
              button,
            ],
          ),
        ),
      ),
    );
  }
}
