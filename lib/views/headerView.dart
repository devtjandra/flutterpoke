import 'package:flutter/material.dart';
import 'package:flutterpoke/utils/extensions.dart';
import 'package:flutterpoke/values.dart';

class HeaderView extends StatelessWidget {
  final String title;
  final String rightTitle;

  HeaderView({this.title, this.rightTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: AppDimens.screenPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              BackButton(color: AppColors.white),
              Text(capitalize(title), style: AppStyles.whiteTitleStyle),
            ],
          ),
          Text(rightTitle, style: AppStyles.whiteTitleStyle)
        ],
      ),
    );
  }
}
