import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_tracker/models/question_model.dart';

final questionRef = FirebaseFirestore.instance.collection('questions');

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key, required this.questionIn}) : super(key: key);
  final num questionIn;

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  QuestionModel questions = QuestionModel();

  @override
  void initState() {
    super.initState();
    // FirebaseFirestore.instance
    //     .collection("questions")
    //     .doc(widget.questionIn.toString())
    //     .get()
    //     .then((value) {
    //   questions = QuestionModel.fromMap(value.data());
    //   setState(() {});
    // });
  }

  double _rating = 1.0;
  num score = 0;

  void _onChanged(double value) {
    setState(() {
      _rating = value;
    });
  }

  Future<QuestionModel> getQuestions(num qi) async {
    DocumentSnapshot doc = await questionRef.doc(qi.toString()).get();
    return questions = QuestionModel.fromMap(doc.data());
  }

  @override
  Widget build(BuildContext context) {
    num questionindex = widget.questionIn;

    return Scaffold(
        body: StreamBuilder(
      stream: getQuestions(questionindex).asStream(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 150,
                width: 390,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.amber[400],borderRadius: BorderRadius.circular(20.0)),
                child: Text(questions.question!,textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontFamily: "farro", fontWeight: FontWeight.bold, fontSize: 25),)),
            Image.network(
              questions.imgurl.toString(),
              errorBuilder: (context, error, stackTrace) =>
                  const CircularProgressIndicator(),
            ),
            questionBtn(
              val: questions.option1txt,
            ),
            questionBtn(
              val: questions.option2txt,
            ),
            questionBtn(
              val: questions.option3txt,
            ),
            questionBtn(
              val: questions.option4txt,
            )
          ],
        ));
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
