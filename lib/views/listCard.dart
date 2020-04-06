import 'package:flutter/material.dart';
import 'package:flutterpoke/values.dart';

class ListCard extends StatelessWidget {
  final List<Widget> children;
  final String title;

  ListCard({this.children, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Card(
            shape: AppStyles.cardShape,
            elevation: 5,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.screenPadding,
                    vertical: AppDimens.mediumPadding),
                child: Column(children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: AppDimens.tinyPadding,
                              bottom: AppDimens.normalPadding),
                          child: Text(title, style: AppStyles.titleTextStyle))),
                  for (Widget child in children) child
                ]))));
  }
}
