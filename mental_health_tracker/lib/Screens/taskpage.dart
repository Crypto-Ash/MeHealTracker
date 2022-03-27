import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health_tracker/Screens/dashboard.dart';
import 'package:mental_health_tracker/Constants/colors.dart';

final taskRef = FirebaseFirestore.instance.collection('tasks');

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdefe7),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.network(
                "https://assets9.lottiefiles.com/packages/lf20_m84fyesq.json",
                fit: BoxFit.fitHeight,
                alignment: Alignment.center),
            const Text(
              "Tasks",
              style: dashboardHeaderTextStyle,
            ),
            StreamBuilder(
              stream: taskRef.doc("zxqL1I2IVZjFqOde1Mgk").snapshots(),
              builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }
                return Column(
                  children: [
                   TaskBar(snapshot.data!["task 1"]),
                   TaskBar(snapshot.data!["task 2"]),
                   TaskBar(snapshot.data!["task 3"]),
                   TaskBar(snapshot.data!["task 4"]),
                   TaskBar(snapshot.data!["task 5"]),
                   TaskBar(snapshot.data!["task 6"]),
                   TaskBar(snapshot.data!["task 7"]),
                   TaskBar(snapshot.data!["task 8"]),
                  ],
                );
            })
          ],
        ),
      ),
    );
  }
  Container TaskBar(String question) => Container(margin: EdgeInsets.all(10),padding: const EdgeInsets.all(15),alignment: Alignment.center,width: 340,height: 90,child: Text(question,style: const TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Farro"),softWrap: true,), decoration: BoxDecoration(color: Color(0xffc0dfd3), borderRadius: BorderRadius.circular(25),),);

}