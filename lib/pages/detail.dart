import 'package:flutter/material.dart';
import 'package:flutterpoke/utils/extensions.dart';
import 'package:flutterpoke/models.dart';
import 'package:flutterpoke/utils/requesters.dart';
import 'package:flutterpoke/utils/routes.dart';
import 'package:flutterpoke/values.dart';
import 'package:flutterpoke/views/abilityView.dart';
import 'package:flutterpoke/views/arcHeader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterpoke/views/evolutionView.dart';
import 'package:flutterpoke/views/headerView.dart';
import 'package:flutterpoke/views/listCard.dart';
import 'package:flutterpoke/views/numberCard.dart';
import 'package:flutterpoke/views/progressBar.dart';
import 'package:flutterpoke/views/simpleButton.dart';
import 'package:flutterpoke/views/spriteBox.dart';
import 'package:flutterpoke/views/statView.dart';
import 'package:flutterpoke/views/typeCard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.poke}) : super(key: key);

  final Pokemon poke;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  bool isClosed = false;
  Species species;
  FetchStatus speciesFetchStatus;

  void changeHeader(double newShrink) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool newClosed = newShrink > 0.3;

      if (newClosed != isClosed)
        setState(() {
          isClosed = newClosed;
        });
    });
  }

  void _fetchSpecies() {
    if (species == null) {
      setState(() {
        speciesFetchStatus = FetchStatus.loading;
      });

      fetchSpecies(widget.poke.species.url)
          .then((newDetail) => setState(() {
                speciesFetchStatus = FetchStatus.success;
                species = newDetail;
              }))
          .catchError((error) => setState(() {
                speciesFetchStatus = FetchStatus.failed;
              }));
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchSpecies();
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
              padding: EdgeInsets.all(AppDimens.bigPadding),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: AppDimens.smallPadding),
                      child: Row(
                        children: <Widget>[
                          for (var type in widget.poke.types)
                            Flexible(child: TypeCard(type.type.name), flex: 1)
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: AppDimens.mediumPadding),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                              child: NumberCard(
                                  number: widget.poke.height * 10,
                                  desc: "cm in height"),
                              flex: 1),
                          Flexible(
                              child: NumberCard(
                                  number: widget.poke.weight ~/ 10,
                                  desc: "kg in weight"),
                              flex: 1)
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppDimens.tinyPadding,
                          horizontal: AppDimens.smallPadding),
                      child: ListCard(
                        title: "Base Statistics",
                        children: <Widget>[
                          StatView(
                              info: "Experience",
                              value: widget.poke.baseExperience.toString()),
                          for (StatPlaceholder stat in widget.poke.stats)
                            StatView(
                                info: stat.stat.name, value: formatStat(stat))
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppDimens.tinyPadding,
                          horizontal: AppDimens.smallPadding),
                      child: ListCard(
                        title: "Abilities",
                        children: <Widget>[
                          if (widget.poke.abilities != null &&
                              widget.poke.abilities.length > 0)
                            for (var ability in widget.poke.abilities)
                              AbilityView(ability: ability)
                          else
                            Text("None", style: AppStyles.textStyle)
                        ],
                      )),
                  if (speciesFetchStatus == FetchStatus.failed)
                    SimpleButton(onPressed: _fetchSpecies, text: "Retry"),
                  AnimatedSize(
                    vsync: this,
                    duration: AppDurations.fadeDuration,
                    curve: Curves.fastOutSlowIn,
                    child: species != null
                        ? Column(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppDimens.tinyPadding,
                                      horizontal: AppDimens.smallPadding),
                                  child: ListCard(
                                      title: "Egg Groups",
                                      children: <Widget>[
                                        for (var group in species.eggGroups)
                                          StatView(info: group.name)
                                      ])),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppDimens.tinyPadding,
                                      horizontal: AppDimens.smallPadding),
                                  child: ListCard(
                                      title: "More Stuff",
                                      children: <Widget>[
                                        StatView(
                                            info: "Color",
                                            value: formatUnderscore(
                                                species.color.name)),
                                        StatView(
                                            info: "Capture Rate",
                                            value: formatCaptureRate(
                                                species.captureRate)),
                                        StatView(
                                            info: "Gender",
                                            value: formatGenderRate(
                                                species.genderRate)),
                                        StatView(
                                            info: "Habitat",
                                            value: formatUnderscore(
                                                species.habitat.name)),
                                        StatView(
                                            info: "Generation",
                                            value: formatUnderscore(
                                                species.generation.name)),
                                      ])),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppDimens.tinyPadding,
                                      horizontal: AppDimens.smallPadding),
                                  child: ListCard(
                                      title: "Evolution",
                                      children: <Widget>[
                                        EvolutionView(
                                          exitPage: widget,
                                          evolvesFrom: species.evolvesFrom,
                                          chainUrl: species.evolutionChain.url,
                                        )
                                      ])),
                            ],
                          )
                        : null,
                  )
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
                  HeaderView(
                    title: widget.poke.name,
                    rightTitle: "#" + widget.poke.id.toString(),
                  ),
                  AnimatedOpacity(
                      opacity: isClosed ? 0.0 : 1.0,
                      duration: AppDurations.quickDuration,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SpriteBox(
                              spriteUrl: widget.poke.sprite.main,
                              gender: widget.poke.sprite.female != null
                                  ? true
                                  : null),
                          if (widget.poke.sprite.female != null)
                            SpriteBox(
                                spriteUrl: widget.poke.sprite.female,
                                gender: false),
                        ],
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
