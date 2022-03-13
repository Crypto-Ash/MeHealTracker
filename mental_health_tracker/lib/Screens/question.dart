import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_tracker/Screens/dashboard.dart';
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
  @override
  void initState() {
    super.initState();
  }

  double _rating = 1.0;

  num score = 0; //  try to print value from that lsit
  

  void _onChanged(double value) {
    setState(() {
      _rating = value;
    });
  }

  int counter = 1;

  @override
  Widget build(BuildContext context) {
    num questionindex = widget.questionIn;
    final updater = userRef.doc(widget.userid);

    Stream<DocumentSnapshot> stream2 = userRef.doc(widget.userid).snapshots();
    return Scaffold(
        body: StreamBuilder(
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
        return Column(
          children: [
            StreamBuilder(
              stream: questionRef.doc(qi.toString()).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator.adaptive();
                }
                QuestionModel question =
                    QuestionModel.fromMap(snapshot.data!.data());
                if (counter < 10) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data!.data().toString()),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.amber),
                        ),
                        child: Text(
                          question.option1txt!,
                          style: TextStyle(
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
                            }
                            updater.update({
                              'userinfo.questionIndex': qi + 1,
                              'userinfo.questionans': (counter + 1).toString(),
                            });
                            counter = counter + 1;
                          });
                        },
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return DashBoardPage();
                            },
                          ));
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueAccent,
                        ),
                        child: const Text("Done",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    ));
  }
}

// single btn layout
class questionBtn extends StatelessWidget {
  questionBtn({Key? key, this.val, this.fun}) : super(key: key);
  final String? val;
  final VoidCallback? fun;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
      ),
      child: Text(
        "$val",
        style:
            TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: "Farro"),
      ),
      onPressed: fun,
    );
  }
}
