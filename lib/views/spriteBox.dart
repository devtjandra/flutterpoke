import 'package:flutter/material.dart';
import 'package:flutterpoke/values.dart';

class SpriteBox extends StatelessWidget {
  final String spriteUrl;

  SpriteBox({this.spriteUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.minPadding),
        child: SizedBox(
            width: AppDimens.spriteSize,
            height: AppDimens.spriteSize,
            child: Card(
              color: AppColors.white,
              elevation: 5,
              shape: AppStyles.buttonShape,
              child: Image.network(
                spriteUrl,
                fit: BoxFit.fill,
              ),
            )));
  }
}
