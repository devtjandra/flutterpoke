import 'package:flutter/material.dart';
import 'package:flutterpoke/values.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  ClickableText({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Text(
          text,
          style: AppStyles.primaryTextStyle,
        ));
  }
}
