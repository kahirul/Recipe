import 'package:flutter/material.dart';
import 'package:recipe/ui/screens/login.dart';
import 'package:recipe/ui/screens/home.dart';
import 'package:recipe/ui/theme.dart';

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe',
      theme: buildTheme(),
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
