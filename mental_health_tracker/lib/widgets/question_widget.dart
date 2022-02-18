import 'package:flutter/material.dart';
import 'package:mental_health_tracker/models/question_model.dart';
import 'package:mental_health_tracker/widgets/rect_button.dart';

class QuestionBtn extends StatefulWidget {
  const QuestionBtn({Key? key, required this.questionModel}) : super(key: key);
  final QuestionModel questionModel;

  @override
  _QuestionBtnState createState() => _QuestionBtnState();
}

class _QuestionBtnState extends State<QuestionBtn> {
  
  double _rating = 1.0;

  void _onChanged(double value) {
    setState(() {
      _rating = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            alignment: Alignment.center,
            height: 100,
            width: 420,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Text(
              "${widget.questionModel.question}",
              softWrap: true,
              style: const TextStyle(
                  color: Colors.white, fontSize: 20.0, fontFamily: "Farro"),
            ),
          ),
        ),
        
        Image.network(widget.questionModel.imgurl.toString(), width: 400.0, height: 250.0,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
          return const CircularProgressIndicator();
        }),
        widget.questionModel.widget == "button"
            ? Buttons(
                widget.questionModel.option1,
                widget.questionModel.option2,
                widget.questionModel.option3,
                widget.questionModel.option4)
            : Container(
                height: 300,
                width: 400,
                padding: EdgeInsets.only(bottom: 20.0),
                child: Slider(
                  value: _rating,
                  min: 1.0,
                  max: 4.0,
                  divisions: 3,
                  onChanged: _onChanged,
                )),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RectButton(onPressed: (){}, ic: Icon(Icons.arrow_forward_ios_rounded)),
            ],
          ),
        )
      ],
    );
  }
}

// 4 btn together
Widget Buttons(option1, option2, option3, option4) {
  return Column(
    children: [
      questionBtn(val: option1),
      questionBtn(val: option2),
      questionBtn(val: option3),
      questionBtn(val: option4),
    ],
  );
}

// single btn layout
class questionBtn extends StatelessWidget {
  const questionBtn({Key? key, required this.val}) : super(key: key);
  final String val;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(),
      child: Text(
        "${val}",
        style:
            TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: "Farro"),
      ),
      onPressed: () {},
    );
  }
}
