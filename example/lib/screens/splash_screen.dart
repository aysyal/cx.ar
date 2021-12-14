import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:arcore_flutter_plugin_example/screens/item_list_screen.dart';

class MySplashScreen extends StatefulWidget {

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState  extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: ItemListScreen(),
      title:  Text(
        'Ar Furniture App',
         style: TextStyle(
           fontWeight: FontWeight.bold,
           fontSize: 26,
           color: Colors.pink,
         )
      ),
      image: Image.asset('assets/topolino.jpg'),
      backgroundColor: Colors.white,
      photoSize: 100,
      loaderColor: Colors.red,
      loadingText: Text(
        'Array[] Yaar',
        style: TextStyle(
          color: Colors.pinkAccent,
          fontSize: 16.0,

        ),
      ),
    );
  }
}