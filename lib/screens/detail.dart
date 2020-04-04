import 'package:flutter/material.dart';
import 'package:flutterpoke/extensions.dart';
import 'package:flutterpoke/models.dart';
import 'package:flutterpoke/values.dart';
import 'package:flutterpoke/views/arcHeader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterpoke/views/spriteBox.dart';
import 'package:flutterpoke/views/typeCard.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.poke}) : super(key: key);

  final Pokemon poke;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double shrink = 0;

  void changeHeader(double newShrink) {
    debugPrint('newShrink: $newShrink');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        shrink = newShrink;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        // Layout widget, arranges things vertically
        children: <Widget>[
          ArcPage(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: AppDimens.screenPadding,
                  left: AppDimens.smallPadding,
                  right: AppDimens.smallPadding,
                  bottom: AppDimens.smallPadding),
              child: Row(
                children: <Widget>[
                  for (var type in widget.poke.types)
                    Flexible(child: TypeCard(type.type.name), flex: 1)
                ],
              ),
            )
          ], onClose: ((newShrink) => changeHeader(newShrink))),
          Container(
              padding: EdgeInsets.only(
                  bottom: AppDimens.smallPadding,
                  top: MediaQuery.of(context).padding.top +
                      AppDimens.smallPadding),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: AppDimens.screenPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            BackButton(color: AppColors.white),
                            Text(capitalize(widget.poke.name),
                                style: AppStyles.whiteTitleStyle),
                          ],
                        ),
                        Text("#" + widget.poke.id.toString(),
                            style: AppStyles.whiteTitleStyle)
                      ],
                    ),
                  ),
                  if (shrink < 1)
                    Opacity(
                        opacity: 1 - shrink,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SpriteBox(
                              spriteUrl: widget.poke.sprite.main,
                            ),
                            if (widget.poke.sprite.female != null)
                              SpriteBox(
                                spriteUrl: widget.poke.sprite.female,
                              ),
                          ],
                        ))
                ],
              ))
        ],
      ),
    );
  }
}
