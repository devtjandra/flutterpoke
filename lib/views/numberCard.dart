import 'package:flutter/material.dart';
import 'package:flutterpoke/values.dart';

class NumberCard extends StatefulWidget {
  final int number;
  final String desc;

  NumberCard({this.number, this.desc});

  @override
  _NumberCardState createState() => _NumberCardState();
}

class _NumberCardState extends State<NumberCard> {
  int numberDisplay = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (numberDisplay < widget.number)
        Future.delayed(const Duration(milliseconds: 30), () {
          setState(() {
            if (numberDisplay < widget.number - 17)
              numberDisplay += 17;
            else
              numberDisplay++;
          });
        });
    });

    return SizedBox(
        width: double.infinity,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.smallPadding),
            child: Card(
                shape: AppStyles.cardShape,
                elevation: 5,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppDimens.screenPadding),
                  child: Column(
                    children: <Widget>[
                      Text(numberDisplay.toString(),
                          style:
                              TextStyle(color: AppColors.dark, fontSize: 30)),
                      Text(widget.desc,
                          style: TextStyle(color: AppColors.grey, fontSize: 10))
                    ],
                  ),
                ))));
  }
}
