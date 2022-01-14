import 'package:cache_manager/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_tracker/Constants/colors.dart';
import 'package:mental_health_tracker/models/user_model.dart';
import 'package:mental_health_tracker/widgets/custom_button.dart';
import 'package:mental_health_tracker/widgets/rect_button.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {

  //Global Scaffold key
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>(); 


  //fetching the current user from firestore
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        backgroundColor: Color(dashbg),
        drawer: Drawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: 400.0,
              height: 100.0,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Hi ${loggedInUser.name}',
                      style: const TextStyle(color: Colors.black, fontSize: 32.0, fontFamily: 'Farro', fontWeight: FontWeight.w600),
                      children: const <TextSpan>[
                        TextSpan(
                            text: '\nYour Report',
                            style: TextStyle(color: Colors.black87, fontSize: 32.0, fontFamily: 'Farro', fontWeight: FontWeight.w600),)
                      ],
                    ),
                  ),
                  RectButton(onPressed: (){setState(() {
                    _scaffoldkey.currentState?.openDrawer();
                  });}, ic: Icon(Icons.menu)),
                ],
              ),
            ),
            Center(
                child: CustomButton(
                    buttonText: "Logout",
                    onPressed: () {
                      DeleteCache.deleteKey("cache",
                          Navigator.of(context).pushReplacementNamed('/login'));
                    },
                    height: 60,
                    width: 80)),
          ],
        ),
      ),
    );
  }
}
