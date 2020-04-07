import 'package:flutter/material.dart';
import 'package:flutterpoke/values.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkedText extends StatelessWidget {
  final String text;
  final String url;

  LinkedText({this.text, this.url});

  _launch() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: 'Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: _launch,
        child: Padding(
            padding: EdgeInsets.all(AppDimens.smallPadding),
            child: Text(text,
                style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold))));
  }
}
