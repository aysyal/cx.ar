import 'package:arcore_flutter_plugin_example/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySplashScreen(),
      //home: HomeScreen(),
    );
  }
}
