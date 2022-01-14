import 'dart:async';
import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_tracker/Constants/colors.dart';
import 'package:mental_health_tracker/Screens/dashboard.dart';

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
    Timer(const Duration(seconds: 5),initiateCache);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(dashbg),
      body: Center(
        child: SizedBox(
          width: 190,
          height: 159,
          child: Text(
            "MeHealTracker",
            style: TextStyle(
              fontSize: 38.0,
              color: Color(splashtxt),
              fontWeight: FontWeight.w500,
              fontFamily: 'Cutive',
            ),
          ),
        ),
      ),
    );
  }
}
