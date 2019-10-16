import 'package:film_app/src/pages/home_page.dart';
import 'package:flutter/material.dart';
 
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
 
class _SplashScreenState extends State<SplashScreen> {
 
  @override
  void initState() {
    super.initState();
 
    initData().then((value) {
      navigateToHomeScreen();
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(37, 63, 82, 0.4),
      child: 
         
         Center(
          child: Image(
            image: AssetImage('assets/img/movie.gif'),
             height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
          ),
        ),
      );
  }
 
  Future initData() async {
    await Future.delayed(Duration(seconds: 5));
  }

  void navigateToHomeScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}