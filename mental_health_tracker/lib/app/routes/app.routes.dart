import 'package:flutter/material.dart';
import 'package:mental_health_tracker/Screens/aboutus.dart';
import 'package:mental_health_tracker/Screens/dashboard.dart';
import 'package:mental_health_tracker/Screens/login.dart';
import 'package:mental_health_tracker/Screens/registration.dart';
import 'package:mental_health_tracker/Screens/splash_screen.dart';
import 'package:mental_health_tracker/Screens/taskpage.dart';

class AppRouter{
  static Route? generateRoute(RouteSettings settings){
    switch(settings.name){
      case "/splash": {
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      }
      case "/dashboard": {
        return MaterialPageRoute(builder: (_) => const DashBoardPage());
      }
      case "/login": {
        return MaterialPageRoute(builder: (_) => const MyLogin());
      }
      case "/signup": {
        return MaterialPageRoute(builder: (_) => const MySignup());
      }
      case "/aboutpage":{
        return MaterialPageRoute(builder: (_) => const AboutUs());
      }
      case "/taskpage":{
        return MaterialPageRoute(builder: (_) => TaskPage());
      }
    }
  }
}