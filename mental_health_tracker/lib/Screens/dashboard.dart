import 'package:flutter/material.dart';
import 'package:mental_health_tracker/Constants/colors.dart';


class DashBoardPage extends StatefulWidget {
  const DashBoardPage({ Key? key }) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MeHealTrack"),
        backgroundColor: Colors.teal[400],
      ),
    );
  }
}