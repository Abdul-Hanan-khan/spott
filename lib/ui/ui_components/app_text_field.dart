import 'package:flutter/material.dart';
import 'package:spott/utils/constants/ui_constants.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? errorMessage;
  final Icon? icon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final Color? backGroundColor;
  final BorderRadius borderRadius;
  final bool isMultiLine;
  final String? suffixText;
  final EdgeInsets? padding;
  final bool autofocus;
  final Function(String value)? onChanged;
  final Function(String value)? onSubmit;
  final TextInputAction? textInputAction;

  const AppTextField({
    Key? key,
    this.hintText,
    this.icon,
    this.isPassword = false,
    this.keyboardType,
    this.controller,
    this.errorMessage,
    this.backGroundColor = Colors.white,
    this.borderRadius = UiConstants.textFieldBorderRadius,
    this.isMultiLine = false,
    this.suffixText,
    this.padding,
    this.autofocus = false,
    this.onChanged,
    this.textInputAction,
    this.onSubmit,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isTextHidden = false;

  @override
  void initState() {
    _isTextHidden = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.autofocus,
      controller: widget.controller,
      obscureText: _isTextHidden,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmit,
      maxLines: widget.isMultiLine ? 5 : 1,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: widget.borderRadius,
            borderSide: BorderSide.none,
          ),
          contentPadding: widget.padding,
          fillColor: widget.backGroundColor,
          prefixIcon: widget.icon,
          filled: true,
          hintText: widget.hintText,
          errorText: widget.errorMessage,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                      _isTextHidden ? Icons.visibility_off : Icons.visibility),
                  onPressed: _onVisibilityChange)
              : null,
          suffixText: widget.suffixText),
    );
  }

  void _onVisibilityChange() {
    setState(() {
      _isTextHidden = !_isTextHidden;
    });
  }
}
