import 'package:cache_manager/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mental_health_tracker/Constants/colors.dart';
import 'package:mental_health_tracker/Screens/question.dart';
import 'package:mental_health_tracker/Services/user_preferences.dart';
import 'package:mental_health_tracker/models/user_model.dart';
import 'package:mental_health_tracker/widgets/rect_button.dart';

final userRef = FirebaseFirestore.instance.collection('users');

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
  final DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {scoreGenrator();});
    });
  }

  Future<String?> getUsername() async {
    return loggedInUser.name;
  }

  void scoreGenrator() {
    final updater =  userRef.doc(loggedInUser.uid);
    if (loggedInUser.score! == 0) {
      updater.update({'userinfo.today': 'N/A'});
      print("N/A");
    }
    else if (loggedInUser.score! <= 15) {
      updater.update({'userinfo.today': 'NotWell'});
      print("NotWell");
    }
    else if (loggedInUser.score! <= 25 && loggedInUser.score! > 15) {
      updater.update({'userinfo.today': 'Good'});
      print("Good");
    } else {
      updater.update({'userinfo.today': 'Better'});
      print("Better");
    }
  }

  @override
  Widget build(BuildContext context) {
    final updater = userRef.doc(loggedInUser.uid);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        backgroundColor: Color(dashbg),
        drawer: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(300.0),
              bottomRight: Radius.circular(300.0)),
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.teal),
                  accountEmail: Text(loggedInUser.email.toString()),
                  accountName: Text(loggedInUser.name.toString()),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/images/boy.png",
                      scale: 2.0,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About Us"),
                  onTap: () {Navigator.pushNamed(context, '/aboutpage');},
                ),
                const Divider(
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
              padding: const EdgeInsets.all(15.0),
              width: 400.0,
              height: 100.0,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder(
                      initialData: "Hey",
                      future: getUsername(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return RichText(
                            text: TextSpan(
                              text: 'Hey ${snapshot.data}',
                              style: dashboardHeaderTextStyle,
                              children: const <TextSpan>[
                                TextSpan(
                                  text: '\nYour Report',
                                  style: dashboardUnderTextStyle,
                                )
                              ],
                            ),
                          );
                        }
                        return const CircularProgressIndicator();
                      }),
                  RectButton(
                      onPressed: () {
                        setState(() {
                          _scaffoldkey.currentState?.openDrawer();
                        });
                      },
                      ic: const Icon(Icons.menu)),
                ],
              ),
            ),
            //Detail-Card
            UserDetailCard(context),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
              child: SizedBox(
                width: 280,
                height: 100,
                child: ElevatedButton(
                    child: const Text(
                      "Questions",
                      style: TextStyle(
                          fontFamily: "farro",
                          fontSize: 25.0,
                          color: Color(0xffd291ff)),
                    ),
                    onPressed: () {
                      print("======>>> $_currentDate ");
                      if (UserSimplePreferences.getDate() == null) {
                        setState(() {
                          UserSimplePreferences.setDate(_currentDate);
                        });
                      } else {
                        if (calculateDifference(DateTime.parse(
                                UserSimplePreferences.getDate()!)) ==
                            0) {
                          print("First If Loop");
                          if (loggedInUser.questionans != "10") {
                            print("2nd If Loop");
                            setState(() {
                              Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return QuestionPage(
                                    questionIn: int.parse(
                                        loggedInUser.questionIndex.toString()),
                                    userid: loggedInUser.uid.toString(),
                                  );
                                },
                              ));
                            });
                          } // if-loop Ends
                          else {
                            print("I am Seting counter to 1");
                            UserSimplePreferences.setCounter(1);
                            Fluttertoast.showToast(
                                msg:
                                    "You Have Completed Today's Questionner!!! \n\t Try Again Later...",
                                textColor: Colors.white,
                                fontSize: 18,
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: const Color(0xffF59397));
                          }
                        } else {
                          if (calculateDifference(DateTime.parse(
                                  UserSimplePreferences.getDate()!)) <
                              0) {
                            print("I am Next Day!!!!");
                            UserSimplePreferences.setDate(_currentDate);
                            UserSimplePreferences.setCounter(1);
                            updater.update({
                              "userinfo.questionans": 0.toString(),
                              "userinfo.Score": 0,
                            });
                            setState(() {
                              Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return QuestionPage(
                                    questionIn: int.parse(
                                        loggedInUser.questionIndex.toString()),
                                    userid: loggedInUser.uid.toString(),
                                  );
                                },
                              ));
                            });
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 3,
                        primary: const Color(0xfff2e7f5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
              ),
            ),
            SizedBox(
              width: 250,
              height: 100,
              child: ElevatedButton(
                  child: const Text("Tasks",
                      style: TextStyle(
                        fontFamily: "farro",
                        fontSize: 25.0,
                        color: Color(0xffd291ff),
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, "/taskpage");
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: const Color(0xfff2e7f5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
            )
          ],
        ),
      ),
    );
  }

  Padding UserDetailCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45.0),
          color: const Color(0xffc0dfd3),
        ),
        height: MediaQuery.of(context).size.height - 450.0,
        width: MediaQuery.of(context).size.width - 50.0,
        child: Stack(
          children: <Widget>[
            const Positioned(
                top: 30.0,
                left: 25.0,
                child: Text(
                  'Today',
                  style: cardlightTextStyle,
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
                  loggedInUser.today ?? "Loading...",
                  style: cardMainTextStyle,
                )),
            Positioned(
                left: 25.0,
                bottom: 39.0,
                child: Text(
                  "Question Answerd : ${loggedInUser.questionans}/10",
                  style: cardMainTextStyle,
                )),
          ],
        ),
      ),
    );
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
