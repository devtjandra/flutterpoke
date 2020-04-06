import 'package:flutter/material.dart';
import 'package:flutterpoke/utils/extensions.dart';
import 'package:flutterpoke/values.dart';

class StatView extends StatelessWidget {
  final String info;
  final String value;

  StatView({this.info, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(formatUnderscore(info).toUpperCase(),
                style: AppStyles.boldDarkTextStyle),
            if (value != null)
              Text(
                formatUnderscore(value),
                style: AppStyles.textStyle,
              )
          ],
        ));
  }
}
