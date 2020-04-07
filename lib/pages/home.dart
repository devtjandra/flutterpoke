import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterpoke/models.dart';
import 'package:flutterpoke/pages/extra.dart';
import 'package:flutterpoke/pages/faves.dart';
import 'package:flutterpoke/utils/routes.dart';

import 'package:flutterpoke/utils/requesters.dart';
import 'package:flutterpoke/pages/detail.dart';
import 'package:flutterpoke/values.dart';
import 'package:flutterpoke/views/progressBar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _counter = 0;
  String searchText = "";
  bool isLoading = false;

  void _go() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    setState(() {
      isLoading = true;
    });

    fetchPokemon(searchText.trim().toLowerCase()).then((pokemon) {
      setState(() {
        isLoading = false;
      });
      Navigator.push(context,
          FadeRoute(exitPage: widget, enterPage: DetailPage(poke: pokemon)));
    }).catchError((error) {
      debugPrint(error.toString());
      Fluttertoast.showToast(msg: "Pokemon not found. Try again.");
      setState(() {
        isLoading = false;
      });
    });
  }

  void _goToExtra() {
    Navigator.push(
        context, FadeRoute(exitPage: widget, enterPage: ExtraPage()));
  }

  void _goToFaves() {
    Navigator.push(
        context, FadeRoute(exitPage: widget, enterPage: FavesPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: AppStyles.gradientDecor,
        ),
        Center(
          //  Positions things in the middle
          child: Column(
            // Layout widget, arranges things vertically
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 220.0,
                  margin: EdgeInsets.only(bottom: 5.0, top: 15.0),
                  child: Card(
                      color: AppColors.white,
                      elevation: 5,
                      shape: AppStyles.buttonShape,
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: AppDimens.screenPadding),
                          child: TextField(
                            onChanged: ((value) {
                              setState(() {
                                searchText = value;
                              });
                            }),
                            style: AppStyles.textStyle,
                            textAlign: TextAlign.center,
                            decoration:
                                InputDecoration.collapsed(hintText: 'Pokemon'),
                          )))),
              RaisedButton(
                  onPressed: (searchText.length > 0 && isLoading == false)
                      ? _go
                      : null,
                  color: Color(0xff333333),
                  shape: AppStyles.buttonShape,
                  child: isLoading
                      ? ProgressBar()
                      : Text(
                          "Go",
                          style: AppStyles.buttonTextStyle,
                        )),
              InkWell(
                onTap: _goToFaves,
                child: Padding(
                    padding: EdgeInsets.all(AppDimens.screenPadding),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.white,
                    )),
              )
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
                onTap: _goToExtra,
                child: Padding(
                    padding: EdgeInsets.all(AppDimens.screenPadding),
                    child: Text("App Info",
                        style: TextStyle(
                            fontSize: 14.0, color: AppColors.white)))))
      ],
    ));
  }
}
