import 'package:flutter/material.dart';
import 'package:flutterpoke/utils/extensions.dart';
import 'package:flutterpoke/models.dart';
import 'package:flutterpoke/utils/requesters.dart';
import 'package:flutterpoke/utils/routes.dart';
import 'package:flutterpoke/values.dart';
import 'package:flutterpoke/views/abilityView.dart';
import 'package:flutterpoke/views/arcHeader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterpoke/views/chainView.dart';
import 'package:flutterpoke/views/headerView.dart';
import 'package:flutterpoke/views/listCard.dart';
import 'package:flutterpoke/views/numberCard.dart';
import 'package:flutterpoke/views/progressBar.dart';
import 'package:flutterpoke/views/simpleButton.dart';
import 'package:flutterpoke/views/spriteBox.dart';
import 'package:flutterpoke/views/statView.dart';
import 'package:flutterpoke/views/typeCard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

typedef PokeCallback = Function(String num);

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.poke}) : super(key: key);

  final Pokemon poke;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with TickerProviderStateMixin, PanelController {
  bool isClosed = false;
  Species species;
  FetchStatus speciesFetchStatus;
  EvolutionChain evolutionChain;
  FetchStatus evolutionChainStatus;
  FetchStatus pokeStatus;

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
                _fetchEvolutionChain();
              }))
          .catchError((error) => setState(() {
                speciesFetchStatus = FetchStatus.failed;
              }));
    }
  }

  void _fetchEvolutionChain() {
    if (evolutionChain == null && species != null) {
      setState(() {
        evolutionChainStatus = FetchStatus.loading;
      });

      fetchChain(species.evolutionChain.url)
          .then((newChain) => setState(() {
                evolutionChainStatus = FetchStatus.success;
                evolutionChain = newChain;
              }))
          .catchError((error) => setState(() {
                evolutionChainStatus = FetchStatus.failed;
              }));
    }
  }

  void _fetchPokemon(String name) {
    setState(() {
      pokeStatus = FetchStatus.loading;
    });

    fetchPokemon(name).then((pokemon) {
      setState(() {
        pokeStatus = FetchStatus.success;
      });
      Navigator.push(context,
          FadeRoute(exitPage: widget, enterPage: DetailPage(poke: pokemon)));
    }).catchError((error) {
      debugPrint(error.toString());
      setState(() {
        Fluttertoast.showToast(msg: "Pokemon not found. Try again.");
        pokeStatus = FetchStatus.failed;
      });
    });
  }

  void _showEvolutionChain() {
    if (evolutionChain != null) open();
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
        body: Stack(children: <Widget>[
          SlidingUpPanel(
            controller: this,
            maxHeight: MediaQuery.of(context).size.height - 120,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            panel: Container(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.screenPadding),
                    child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                            top: AppDimens.screenPadding,
                            bottom: AppDimens.bigPadding),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: AppDimens.mediumPadding),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: AppDimens.normalPadding),
                                      child: InkWell(
                                          onTap: () => close(),
                                          child: Icon(Icons.close,
                                              size: 20, color: AppColors.dark)),
                                    ),
                                    Text(
                                        formatUnderscore(widget.poke.name) +
                                            (widget.poke.name[widget
                                                            .poke.name.length -
                                                        1] ==
                                                    "s"
                                                ? "'"
                                                : "'s") +
                                            " Evolution Chain",
                                        style: AppStyles.titleTextStyle)
                                  ],
                                ),
                              ),
                              if (evolutionChainStatus == FetchStatus.loading)
                                AnimatedOpacity(
                                    opacity: evolutionChainStatus ==
                                            FetchStatus.loading
                                        ? 1
                                        : 0,
                                    duration: AppDurations.arcDuration,
                                    child: ProgressBar()),
                              if (evolutionChainStatus == FetchStatus.failed)
                                SimpleButton(
                                  text: "Retry",
                                  onPressed: _fetchEvolutionChain,
                                ),
                              if (evolutionChain != null)
                                evolutionChain.chain.evolvesTo.length > 0
                                    ? ChainView(
                                        main: widget.poke.name.toLowerCase(),
                                        chain: evolutionChain.chain,
                                        pokeClick: (poke) =>
                                            _fetchPokemon(poke))
                                    : Text(
                                        "No evolution chain found for " +
                                            formatUnderscore(widget.poke.name) +
                                            " :(",
                                        style: AppStyles.textStyle)
                            ],
                          ),
                        )))),
            minHeight: 0,
            defaultPanelState: PanelState.CLOSED,
            body: Stack(
              // Layout widget, arranges things vertically
              children: <Widget>[
                ArcPage(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(AppDimens.bigPadding),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding:
                                EdgeInsets.only(top: AppDimens.smallPadding),
                            child: Row(
                              children: <Widget>[
                                for (var type in widget.poke.types)
                                  Flexible(
                                      child: TypeCard(type.type.name), flex: 1)
                              ],
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(top: AppDimens.mediumPadding),
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
                                    value:
                                        widget.poke.baseExperience.toString()),
                                for (StatPlaceholder stat in widget.poke.stats)
                                  StatView(
                                      info: stat.stat.name,
                                      value: formatStat(stat))
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
                                              for (var group
                                                  in species.eggGroups)
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
                                        child: SimpleButton(
                                          text: "View Evolution Chain",
                                          onPressed: _showEvolutionChain,
                                        )),
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
          ),
          if (pokeStatus == FetchStatus.loading)
            SizedBox.expand(
                child: AnimatedOpacity(
                    opacity: pokeStatus == FetchStatus.loading ? 1 : 0,
                    duration: AppDurations.fadeDuration,
                    child: Container(
                        color: AppColors.whiteTransparent,
                        child: Stack(
                          children: <Widget>[Center(child: ProgressBar())],
                        ))
                    // Expanded(...)
                    ))
        ]));
  }
}
