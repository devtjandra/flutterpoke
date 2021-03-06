import 'package:flutter/material.dart';
import 'package:flutterpoke/models.dart';
import 'package:flutterpoke/utils/extensions.dart';
import 'package:flutterpoke/utils/requesters.dart';
import 'package:flutterpoke/values.dart';
import 'package:flutterpoke/views/progressBar.dart';
import 'package:flutterpoke/views/simpleButton.dart';

class AbilityView extends StatefulWidget {
  final AbilityPlaceholder ability;

  AbilityView({Key key, this.ability}) : super(key: key);

  @override
  _AbilityViewState createState() => _AbilityViewState();
}

class _AbilityViewState extends State<AbilityView>
    with SingleTickerProviderStateMixin {
  AbilityDetail detail;
  FetchStatus status;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetch();
    });
  }

  void _fetch() {
    if (detail == null) {
      setState(() {
        status = FetchStatus.loading;
      });

      fetchAbility(widget.ability.ability.url)
          .then((newDetail) => setState(() {
                status = FetchStatus.success;
                detail = newDetail;
              }))
          .catchError((error) => setState(() {
                status = FetchStatus.failed;
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: AppDimens.tinyPadding, bottom: AppDimens.normalPadding),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(formatUnderscore(widget.ability.ability.name),
                      style: AppStyles.textStyle),
                  if (widget.ability.isHidden)
                    Text("Hidden",
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontStyle: FontStyle.italic))
                ],
              ),
              AnimatedOpacity(
                  opacity: status == FetchStatus.loading ? 1 : 0,
                  duration: AppDurations.arcDuration,
                  child: ProgressBar()),
              if (status == FetchStatus.failed)
                SimpleButton(
                  text: "Retry",
                  onPressed: _fetch,
                ),
              AnimatedSize(
                vsync: this,
                duration: AppDurations.fadeDuration,
                curve: Curves.fastOutSlowIn,
                child: Column(
                  children: <Widget>[
                    AnimatedOpacity(
                        opacity: detail != null ? 1 : 0,
                        duration: AppDurations.fadeDuration,
                        child: detail != null && detail.effectEntries.length > 0
                            ? Text(detail.effectEntries[0].shortEffect,
                                textAlign: TextAlign.center,
                                style: AppStyles.descriptionTextStyle)
                            : null)
                  ],
                ),
              )
            ])));
  }
}
