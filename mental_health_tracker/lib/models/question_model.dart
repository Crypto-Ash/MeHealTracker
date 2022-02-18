class QuestionModel {
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? widget;
  String? uid;
  String? imgurl;

  QuestionModel({this.uid, this.question, this.widget, this.option1, this.option2, this.option3, this.option4, this.imgurl});

  factory QuestionModel.fromMap(map){
    return QuestionModel(
      uid: map['uid'],
      question: map['question'],
      option1: map['option1'],
      option2: map['option2'],
      option3: map['option3'],
      option4: map['option4'],
      widget: map['widget'],
      imgurl: map['imgurl'],
    );
  }

  
}