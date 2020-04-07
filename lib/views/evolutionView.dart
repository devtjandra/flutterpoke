import 'package:flutter/material.dart';
import 'package:flutterpoke/models.dart';
import 'package:flutterpoke/utils/extensions.dart';
import 'package:flutterpoke/utils/requesters.dart';
import 'package:flutterpoke/values.dart';
import 'package:flutterpoke/views/clickableText.dart';
import 'package:flutterpoke/views/progressBar.dart';

class EvolutionView extends StatefulWidget {
  final Ability evolvesFrom;
  final VoidCallback onPressed;

  EvolutionView({Key key, this.evolvesFrom, this.onPressed}) : super(key: key);

  @override
  _EvolutionViewState createState() => _EvolutionViewState();
}

class _EvolutionViewState extends State<EvolutionView>
    with SingleTickerProviderStateMixin {
  FetchStatus status;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: AppDimens.tinyPadding, bottom: AppDimens.normalPadding),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Text("Evolved from ", style: AppStyles.textStyle),
              widget.evolvesFrom != null
                  ? ClickableText(
                      text: formatUnderscore(widget.evolvesFrom.name),
                      onPressed: widget.onPressed)
                  : Text("nothing", style: AppStyles.textStyle),
            ],
          ),
          AnimatedOpacity(
              opacity: status == FetchStatus.loading ? 1 : 0,
              duration: AppDurations.arcDuration,
              child: ProgressBar()),
          if (status == FetchStatus.failed)
            RaisedButton(
                onPressed: widget.onPressed,
                color: Color(0xff333333),
                shape: AppStyles.buttonShape,
                child: Text(
                  "Retry",
                  style: AppStyles.buttonTextStyle,
                )),
        ]));
  }
}
