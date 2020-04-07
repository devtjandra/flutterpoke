import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterpoke/models.dart';
import 'package:flutterpoke/utils/routes.dart';

import 'package:flutterpoke/utils/requesters.dart';
import 'package:flutterpoke/pages/detail.dart';
import 'package:flutterpoke/values.dart';
import 'package:flutterpoke/views/linkedText.dart';
import 'package:flutterpoke/views/progressBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';

class ExtraPage extends StatefulWidget {
  ExtraPage({Key key}) : super(key: key);

  @override
  _ExtraPageState createState() => _ExtraPageState();
}

class _ExtraPageState extends State<ExtraPage> {
  String versionName = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getPackage();
    });
  }

  _getPackage() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionName = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: AppStyles.gradientDecor,
        ),
        Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    AppDimens.smallPadding),
            child: BackButton(color: AppColors.white)),
        Padding(
          padding: EdgeInsets.all(AppDimens.screenPadding),
          child: Center(
            //  Positions things in the middle
            child: Column(
              // Layout widget, arranges things vertically
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "This app was created solely for learning purposes. Below are a list of third-party APIs and tools used in the process:\n",
                  style: TextStyle(fontSize: 14.0, color: AppColors.white),
                ),
                LinkedText(text: "Poke API", url: "https://pokeapi.co/"),
                LinkedText(
                    text: "FlutterToast",
                    url: "https://github.com/PonnamKarthik/FlutterToast"),
                LinkedText(
                    text: "Sliding Up Panel",
                    url: "https://github.com/akshathjain/sliding_up_panel"),
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(AppDimens.screenPadding),
                child: Text(versionName,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.white,
                        fontStyle: FontStyle.italic))))
      ],
    ));
  }
}
