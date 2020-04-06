import 'package:flutter/material.dart';
import 'package:flutterpoke/values.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.loadSize,
      width: AppDimens.loadSize,
      child: CircularProgressIndicator(
        strokeWidth: 1.0,
        backgroundColor: AppColors.white,
      ),
    );
  }
}
