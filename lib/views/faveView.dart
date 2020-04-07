import 'package:flutter/material.dart';
import 'package:flutterpoke/models.dart';
import 'package:flutterpoke/utils/extensions.dart';
import 'package:flutterpoke/values.dart';

class FaveView extends StatelessWidget {
  final FavePoke poke;
  final VoidCallback onPressed;

  FaveView({this.poke, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: AppColors.light,
              width: 1,
            ))),
            padding: EdgeInsets.only(right: AppDimens.screenPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: AppDimens.spriteSize,
                      height: AppDimens.spriteSize,
                      child: Image.network(
                        poke.sprite,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: AppDimens.normalPadding),
                        child: Text(formatUnderscore(poke.name),
                            style: AppStyles.primaryTextStyle)),
                  ],
                ),
                Text("#${poke.id}", style: AppStyles.titleTextStyle)
              ],
            )));
  }
}
