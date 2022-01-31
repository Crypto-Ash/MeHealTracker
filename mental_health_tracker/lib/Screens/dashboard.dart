import 'package:cache_manager/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_tracker/Constants/colors.dart';
import 'package:mental_health_tracker/models/user_model.dart';
import 'package:mental_health_tracker/widgets/rect_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)),
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: Text(loggedInUser.email.toString()),
                  accountName: Text(loggedInUser.name.toString()),
                  currentAccountPicture: CircleAvatar(
                    child: Text(loggedInUser.name
                        .toString()
                        .substring(0, 2)
                        .toUpperCase()),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About Us"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.rate_review),
                  title: Text("Rate and Review"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.flag),
                  title: Text("Privacy Policy"),
                  onTap: () {},
                ),
                Divider(
                  thickness: 2.0,
                ),
                ListTile(
                  leading: Icon(Icons.logout_rounded),
                  title: Text("Log-Out"),
                  onTap: () {
                    DeleteCache.deleteKey("cache",
                        Navigator.of(context).pushReplacementNamed('/login'));
                  },
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              width: 400.0,
              height: 100.0,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Hey ${loggedInUser.name}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 32.0,
                          fontFamily: 'Farro',
                          fontWeight: FontWeight.w600),
                      children: const <TextSpan>[
                        TextSpan(
                          text: '\nYour Report',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 32.0,
                              fontFamily: 'Farro',
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  RectButton(
                      onPressed: () {
                        setState(() {
                          _scaffoldkey.currentState?.openDrawer();
                        });
                      },
                      ic: Icon(Icons.menu)),
                ],
              ),
            ),
            //Detail-Card
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45.0),
                  color: const Color(cardbg),
                ),
                height: MediaQuery.of(context).size.height - 450.0,
                width: MediaQuery.of(context).size.width - 50.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 30.0,
                        left: 25.0,
                        child: Text(
                          'Today',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 20.0,
                          ),
                        )),
                    Positioned(
                      right: 30.0,
                      top: 25.0,
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                        ),
                        child: Image.asset('assets/images/boy.png'),
                      ),
                    ),
                    Positioned(
                        left: 25.0,
                        top: 90.0,
                        child: Text(
                          'Good',
                          style: TextStyle(
                              fontSize: 29.0,
                              fontFamily: 'Farro',
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        )),
                    Positioned(
                        left: 30.0,
                        top: 130.0,
                        child: CircularPercentIndicator(
                          radius: 80.0,
                          lineWidth: 6.0,
                          percent: 0.6,
                          center: new Text("60%"),
                          progressColor: Colors.green,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
