import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_tracker/Services/database.dart';
import 'package:mental_health_tracker/models/question_model.dart';
import 'package:mental_health_tracker/widgets/question_widget.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({ Key? key }) : super(key: key);


  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  QuestionModel questions = QuestionModel();

  String quetionindex = "1";
  

  

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("questions")
        .doc(quetionindex)
        .get()
        .then((value) {
      this.questions = QuestionModel.fromMap(value.data());
      setState(() {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuestionBtn(questionModel: this.questions,),
    );
  }
}