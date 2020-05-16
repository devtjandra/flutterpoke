import 'package:flutter/material.dart';
import 'package:flutterpoke/pages/home.dart';
import 'package:flutterpoke/values.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Poke',
        home: HomePage(),
        theme: ThemeData(
            accentColor: AppColors.primary, primaryColor: AppColors.primary));
  }
}
