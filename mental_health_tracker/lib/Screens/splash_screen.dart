import 'dart:async';
import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health_tracker/Constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Cache_Manger Integration
  // A future needs an async
  Future initiateCache() async {
    CacheManagerUtils.conditionalCache(
        key: "cache",
        valueType: ValueType.StringValue,
        actionIfNull: () {
          Navigator.of(context).pushReplacementNamed('/login');
        },
        actionIfNotNull: () {
          Navigator.of(context).pushReplacementNamed('/dashboard');
        });
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 5), initiateCache);
    Timer(const Duration(seconds: 2), (){ setState(() {
      _isChange = true;
    });});
    super.initState();
  }

  bool _isChange = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(dashbg),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width,
              child: Lottie.network(
              "https://assets7.lottiefiles.com/packages/lf20_xduq8cpf.json",
              fit: BoxFit.fitHeight,
              alignment: Alignment.center),),
            AnimatedDefaultTextStyle(child: Text("Meheal\nTracker"),duration: Duration(milliseconds: 800),style:_isChange ? splashAfterTextStyle:splashMainTextStyle, curve: Curves.easeInCirc,),
          ],
        ));
  }
}
