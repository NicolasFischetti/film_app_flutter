import 'package:film_app/src/pages/film_detail.dart';
import 'package:film_app/src/pages/home_page.dart';
import 'package:film_app/src/widgets/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Films App',
      home: SplashScreen(),
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'detail' : (BuildContext context) => FilmDetail()
      },
    );
  }
}   