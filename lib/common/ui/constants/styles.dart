import 'package:flutter/material.dart';

import 'colors.dart';

class AppStyle {
  AppStyle();
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, color: Colors.white),
      backgroundColor: Colors.cyan[700]);
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 40,
    color: PalletColors.whiteColor,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subtitleTextStyle =
      TextStyle(fontSize: 16, color: Colors.white);
}
