import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spott/utils/constants/app_colors.dart';

class AppCheckBox extends StatefulWidget {
  final Function(bool selectedValue)? onValueChanged;
  const AppCheckBox({this.onValueChanged, Key? key}) : super(key: key);

  @override
  _AppCheckBoxState createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: _onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CupertinoColors.systemGrey4,
          gradient: _value ? AppColors.greenGradient : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: _value
              ? const Icon(
                  Icons.check,
                  size: 20.0,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  size: 20.0,
                  color: Colors.transparent,
                ),
        ),
      ),
    ));
  }

  void _onTap() {
    setState(() {
      _value = !_value;
    });
    widget.onValueChanged?.call(_value);
  }
}
