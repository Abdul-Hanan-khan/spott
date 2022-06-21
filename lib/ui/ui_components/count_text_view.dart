import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountTextView extends StatelessWidget {
  final int? _count;
  final TextStyle? style;
  const CountTextView(this._count, {Key? key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _count != null
          ? NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
              .format(_count)
          : '',
      style: style ?? TextStyle(color: Theme.of(context).hintColor),
    );
  }
}
