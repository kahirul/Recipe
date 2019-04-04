import 'package:flutter/material.dart';

ThemeData buildTheme() {
  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      headline: base.headline.copyWith(
        fontFamily: 'Roboto-Medium',
        fontSize: 40.0,
        color: Colors.black54,
      ),
      title: base.title.copyWith(
        fontFamily: 'Roboto-Medium',
        fontSize: 15.0,
        color: Colors.black54,
      ),
    );
  }

  final ThemeData base = ThemeData.light();

  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryColor: Colors.red,
    accentColor: Colors.redAccent,
    indicatorColor: Colors.white,
    iconTheme: base.iconTheme.copyWith(
      color: Colors.red,
    ),
    buttonColor: Colors.white,
  );
}
