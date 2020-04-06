import 'package:flutter/material.dart';
import 'package:flutterpoke/values.dart';

class SpriteBox extends StatelessWidget {
  final String spriteUrl;
  final bool gender;

  SpriteBox({this.spriteUrl, this.gender});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.minPadding),
        child: Column(
          children: <Widget>[
            SizedBox(
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
                )),
            if (gender != null)
              Container(
                padding: EdgeInsets.only(top: AppDimens.minPadding),
                child: Text(gender ? "M" : "F",
                    style: AppStyles.boldDarkTextStyle),
              )
          ],
        ));
  }
}
