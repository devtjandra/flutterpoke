import 'package:flutter/material.dart';
import 'package:flutterpoke/values.dart';

class SimpleButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  SimpleButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: onPressed,
        color: Color(0xff333333),
        shape: AppStyles.buttonShape,
        child: Text(
          text,
          style: AppStyles.buttonTextStyle,
        ));
  }
}
