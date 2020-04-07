import 'package:flutter/material.dart';
import 'package:flutterpoke/models.dart';
import 'package:flutterpoke/pages/detail.dart';
import 'package:flutterpoke/utils/extensions.dart';
import 'package:flutterpoke/values.dart';
import 'package:flutterpoke/views/clickableText.dart';

class ChainView extends StatelessWidget {
  final Chain chain;
  final PokeCallback pokeClick;
  final String main;

  ChainView({this.chain, this.pokeClick, this.main});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (chain.details != null)
          Align(
              alignment: Alignment.centerLeft,
              child: Text(getDetailString(chain.details),
                  style: AppStyles.descriptionTextStyle)),
        Align(
            alignment: Alignment.centerLeft,
            child: chain.species.name == main
                ? Text(formatUnderscore(chain.species.name),
                    style: TextStyle(
                        color: AppColors.dark, fontWeight: FontWeight.bold))
                : ClickableText(
                    text: formatUnderscore(chain.species.name),
                    onPressed: () => pokeClick(chain.species.name))),
        if (chain.evolvesTo.length > 0)
          Padding(
              padding: EdgeInsets.only(
                  top: AppDimens.smallPadding,
                  bottom: AppDimens.mediumPadding,
                  left: AppDimens.mediumPadding,
                  right: AppDimens.smallPadding),
              child: Container(
                  padding: EdgeInsets.only(
                      left: AppDimens.normalPadding,
                      bottom: AppDimens.mediumPadding),
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                    color: AppColors.dark,
                    width: 2,
                  ))),
                  child: Column(
                    children: <Widget>[
                      for (Chain baby in chain.evolvesTo)
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: AppDimens.smallPadding),
                            child: ChainView(
                              chain: baby,
                              main: main,
                              pokeClick: pokeClick,
                            ))
                    ],
                  )))
      ],
    );
  }
}

String getDetailString(EvolutionDetail detail) {
  String result = "";

  switch (detail.trigger.name) {
    case "level-up":
      result += "Level up ";
      if (detail.minLevel != null)
        result += "to " + detail.minLevel.toString() + " ";
      break;

    case "trade":
      result += "Trade ";
      break;

    case "use-item":
      if (detail.item != null)
        result += "Use " + formatUnderscore(detail.item.name) + " ";
      break;

    case "shed":
      result += "Through shedding ";
  }

  if (detail.minHappiness != null) result += "with happiness ";
  if (detail.minAffection != null) result += "with affection ";
  if (detail.minBeauty != null) result += "with beauty ";

  if (detail.heldItem != null)
    result += "while holding " + formatUnderscore(detail.heldItem.name) + " ";

  if (detail.timeOfDay.length > 0)
    result += "during the " + detail.timeOfDay.toLowerCase() + " ";

  if (detail.location != null)
    result += "at " + formatUnderscore(detail.location.name) + " ";

  if (detail.gender != null)
    result += "(" + getGenderString(detail.gender) + ") ";

  return result.trim();
}

String getGenderString(int gender) {
  switch (gender) {
    case 1:
      return "Female";
    case 2:
      return "Male";
    default:
      return "Genderless";
  }
}
