import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_tracker/Screens/dashboard.dart';
import 'package:mental_health_tracker/Services/user_preferences.dart';
import 'package:mental_health_tracker/models/question_model.dart';
import 'package:mental_health_tracker/models/user_model.dart';

final questionRef = FirebaseFirestore.instance.collection('questions');
final userRef = FirebaseFirestore.instance.collection('users');

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key, required this.questionIn, required this.userid})
      : super(key: key);
  final num questionIn;
  final String userid;

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

  double _rating = 1.0;

  num score = 0; //  try to print value from that lsit

  void _onChanged(double value) {
    setState(() {
      _rating = value;
    });
  }

  int counter = 1;

  @override
  void initState() {
    super.initState();
    counter = UserSimplePreferences.getCounter() ?? 1;
  }
  @override
  Widget build(BuildContext context) {
    num questionindex = widget.questionIn;
    final updater = userRef.doc(widget.userid);

    Stream<DocumentSnapshot> stream2 = userRef.doc(widget.userid).snapshots();
    return StreamBuilder(
      stream: stream2,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text("Loading..."),
          );
        }
        late num qi;
        qi = snapshot.data!['userinfo']['questionIndex'];
        print("======><< $counter");
        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.blueAccent,
            child: StreamBuilder(
                    stream: questionRef.doc(qi.toString()).snapshots(),
                    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator.adaptive();
                      }
                      QuestionModel question =
                          QuestionModel.fromMap(snapshot.data!.data());
                      if (counter <= 10) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const Spacer(flex: 1,),
                            QuestionBar(question),
                            const Spacer(flex: 1,),
                            questionButtonOne(question, updater, qi, context, question.option1txt),
                            questionButtonOne(question, updater, qi, context, question.option2txt),
                            questionButtonOne(question, updater, qi, context, question.option3txt),
                            questionButtonOne(question, updater, qi, context, question.option4txt),
                            const Spacer(flex: 2,),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                    },
                  ),
          ),
        );
      },
    );
  }

  ElevatedButton questionButtonOne(QuestionModel question, DocumentReference<Map<String, dynamic>> updater, num qi, BuildContext context,String? optionnum) {
    return ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.amber),
                            ),
                            child: Text(
                              optionnum!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: "Farro"),
                            ),
                            onPressed: () {
                              setState(() {
                                if (counter == 10) {
                                  updater.update({
                                    'userinfo.questionIndex': qi + 1,
                                  });
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                                      return DashBoardPage();
                                    },
                                  ));
                                }
                                updater.update({
                                  'userinfo.questionIndex': qi + 1,
                                  'userinfo.questionans': (counter).toString(),
                                });
                                counter = counter + 1;
                                UserSimplePreferences.setCounter(counter);
                              });
                            },
                          );
  }

  Container QuestionBar(QuestionModel question) => Container(padding: EdgeInsets.all(15),alignment: Alignment.center,width: 340,height: 100,child: Text(question.question.toString(),style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Farro"),softWrap: true,), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(25),),);
}