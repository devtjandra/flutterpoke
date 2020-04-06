import 'package:flutter/material.dart';
import 'package:flutterpoke/models.dart';
import 'package:flutterpoke/pages/detail.dart';
import 'package:flutterpoke/utils/extensions.dart';
import 'package:flutterpoke/utils/requesters.dart';
import 'package:flutterpoke/utils/routes.dart';
import 'package:flutterpoke/values.dart';
import 'package:flutterpoke/views/clickableText.dart';

import 'package:fluttertoast/fluttertoast.dart';

class EvolutionView extends StatefulWidget {
  final Ability evolvesFrom;
  final String chainUrl;
  final Widget exitPage;

  EvolutionView({Key key, this.exitPage, this.evolvesFrom, this.chainUrl})
      : super(key: key);

  @override
  _EvolutionViewState createState() => _EvolutionViewState();
}

class _EvolutionViewState extends State<EvolutionView>
    with SingleTickerProviderStateMixin {
  FetchStatus status;

  void _fetchPokemon(String name) {
    debugPrint("Fetching pokemon: " + name);
    fetchPokemon(name).then((pokemon) {
      debugPrint("Pokemon fetched!");
      Navigator.push(
          context,
          EnterExitRoute(
              exitPage: widget.exitPage, enterPage: DetailPage(poke: pokemon)));
    }).catchError((error) {
      debugPrint(error.toString());
      Fluttertoast.showToast(msg: "Pokemon not found. Try again.");
    });
  }

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _fetch();
    // });
  }

  // void _fetch() {
  //   if (detail == null) {
  //     setState(() {
  //       status = FetchStatus.loading;
  //     });

  //     fetchAbility(widget.ability.ability.url)
  //         .then((newDetail) => setState(() {
  //               status = FetchStatus.success;
  //               detail = newDetail;
  //             }))
  //         .catchError((error) => setState(() {
  //               status = FetchStatus.failed;
  //             }));
  //   }
  // }

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
                      onPressed: () => _fetchPokemon(widget.evolvesFrom.name))
                  : Text("nothing", style: AppStyles.textStyle),
            ],
          ),

          // AnimatedOpacity(
          //     opacity: status == FetchStatus.loading ? 1 : 0,
          //     duration: AppDurations.arcDuration,
          //     child: ProgressBar()),
          // if (status == FetchStatus.failed)
          //   RaisedButton(
          //       onPressed: _fetch,
          //       color: Color(0xff333333),
          //       shape: AppStyles.buttonShape,
          //       child: Text(
          //         "Retry",
          //         style: AppStyles.buttonTextStyle,
          //       )),
          // AnimatedSize(
          //   vsync: this,
          //   duration: AppDurations.fadeDuration,
          //   curve: Curves.fastOutSlowIn,
          //   child: Column(
          //     children: <Widget>[
          //       AnimatedOpacity(
          //           opacity: detail != null ? 1 : 0,
          //           duration: AppDurations.fadeDuration,
          //           child: detail != null && detail.effectEntries.length > 0
          //               ? Text(detail.effectEntries[0].shortEffect,
          //                   style: TextStyle(
          //                       fontSize: 12, color: AppColors.grey))
          //               : null)
          //     ],
          //   ),
          // )
        ]));
  }
}
