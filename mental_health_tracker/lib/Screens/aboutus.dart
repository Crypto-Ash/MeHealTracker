import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mental_health_tracker/Constants/colors.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(microseconds: 300), (){ setState(() {
      _isChange = true;
    });});
  }

  bool _isChange = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(splashbg),
      body: Column(
        children: <Widget>[
          AnimatedContainer(
            margin: const EdgeInsets.all(20),
            alignment: Alignment.center,
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15),  ),
            duration: Duration(seconds: 3),
            child: Column(
              children: <Widget>[
                AnimatedDefaultTextStyle(
                    child: Text("About-Us"),
                    style: _isChange ? aboutheadStyleafter : aboutheadStyle,
                    duration: Duration(microseconds: 800),
                    ),
                    Padding(
            padding: EdgeInsets.all(10.0),
            child: AnimatedDefaultTextStyle(
                  child: const Text("This Is Our Final Year Project Based On Mental Health.\n\nName : Yash Budhe \nRoll No: 709\n\nName : Amey Lad \nRoll No: 757",softWrap: true,),
                  style: _isChange ? aboutinnerStyleafter : aboutinnerStyle,
                  duration: Duration(milliseconds: 400),
                  ),
          ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
