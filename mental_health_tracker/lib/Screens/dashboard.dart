import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_tracker/Constants/colors.dart';
import 'package:mental_health_tracker/widgets/custom_button.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

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
      body: Center(
          child: CustomButton(
              buttonText: "Logout", onPressed: () {
                DeleteCache.deleteKey("cache", Navigator.of(context).pushReplacementNamed('/login'));
              }, height: 60, width: 80)),
    );
  }
}
