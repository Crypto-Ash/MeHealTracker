import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_tracker/models/question_model.dart';

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
    FirebaseFirestore.instance
        .collection("questions")
        .doc(widget.questionIn.toString())
        .get()
        .then((value) {
      questions = QuestionModel.fromMap(value.data());
      setState(() {});
    });
  }

  double _rating = 1.0;
  num score = 0;

  void _onChanged(double value) {
    setState(() {
      _rating = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    num questionindex = widget.questionIn;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(10, 26, 10, 10),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.amber[200],
              borderRadius: BorderRadius.circular(20),
            ),
            height: 150,
            width: 380,
            child: Text(
              "${questions.question}",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Farro",
              ),
              softWrap: true,
            ),
          ),
          Image.network(questions.imgurl.toString(),
              width: 400.0, height: 250.0, errorBuilder: (BuildContext context,
                  Object exception, StackTrace? stackTrace) {
            return const CircularProgressIndicator();
          }),
          // Buttons From Here
          Container(
            child: Column(
              children: [
                questionBtn(
                  val: questions.option1txt,
                  fun: () => {
                    score = questions.option1pt!,
                  },
                ),
                questionBtn(
                  val: questions.option2txt,
                  fun: () => {
                    score = questions.option2pt!,
                  },
                ),
                questionBtn(
                  val: questions.option3txt,
                  fun: () => {
                    score = questions.option3pt!,
                  },
                ),
                questionBtn(
                  val: questions.option4txt,
                  fun: () => {
                    score = questions.option4pt!,
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

// single btn layout
class questionBtn extends StatelessWidget {
  const questionBtn({Key? key, this.val, this.fun}) : super(key: key);
  final String? val;
  final VoidCallback? fun;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(),
      child: Text(
        "$val",
        style:
            TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: "Farro"),
      ),
      onPressed: fun,
    );
  }
}
