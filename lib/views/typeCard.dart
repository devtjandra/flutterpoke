import 'package:flutter/material.dart';
import 'package:flutterpoke/values.dart';

class TypeCard extends StatelessWidget {
  final String type;

  TypeCard(this.type);

  @override
  Widget build(BuildContext context) {
    int cardColor;

    switch (type) {
      case "normal":
        cardColor = 0xffb5b4ae;
        break;

      case "fighting":
        cardColor = 0xff5c352a;
        break;

      case "flying":
        cardColor = 0xff72a9d6;
        break;

      case "poison":
        cardColor = 0xffa14fbd;
        break;

      case "ground":
        cardColor = 0xffdb9f5e;
        break;

      case "rock":
        cardColor = 0xffad8f6a;
        break;

      case "bug":
        cardColor = 0xffbcf266;
        break;

      case "ghost":
        cardColor = 0xff5356ad;
        break;

      case "steel":
        cardColor = 0xffadadad;
        break;

      case "fire":
        cardColor = 0xffe85d41;
        break;

      case "electric":
        cardColor = 0xfff7d23e;
        break;

      case "grass":
        cardColor = 0xff52cc5a;
        break;

      case "water":
        cardColor = 0xff40b1de;
        break;

      case "psychic":
        cardColor = 0xffe34272;
        break;

      case "ice":
        cardColor = 0xff8be6f0;
        break;

      case "dragon":
        cardColor = 0xff8e5ec4;
        break;

      case "dark":
        cardColor = 0xff5e5c61;
        break;

      case "fairy":
        cardColor = 0xffed8ece;
        break;
    }

    return SizedBox(
        width: double.infinity,
        child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Color(cardColor),
                borderRadius: BorderRadius.circular(1000.0)),
            height: 7,
            margin: EdgeInsets.all(AppDimens.smallPadding),
          ),
          Text(type.toUpperCase(), style: AppStyles.boldDarkTextStyle)
        ]));
    // Card(
    //     margin: const EdgeInsets.all(AppDimens.tinyPadding),
    //     color: Color(cardColor),
    //     elevation: 3,
    //     shape: RoundedRectangleBorder(
    //         borderRadius: new BorderRadius.circular(10.0)),
    //     child: Container(
    //       padding: const EdgeInsets.symmetric(vertical: 15.0),
    //       child: Text(type,
    //           textAlign: TextAlign.center,
    //           style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 30)),
    //     )));
  }
}
