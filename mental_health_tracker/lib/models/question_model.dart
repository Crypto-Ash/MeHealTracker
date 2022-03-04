class QuestionModel {
  String? question;
  String? option1txt;
  String? option2txt;
  String? option3txt;
  String? option4txt;
  num? option1pt;
  num? option2pt;
  num? option3pt;
  num? option4pt;
  String? widget;
  String? uid;
  String? imgurl;
  Map? option1;
  Map? option2;
  Map? option3;
  Map? option4;

  QuestionModel({this.uid, this.question, this.widget, this.option1, this.option2, this.option3, this.option4, this.imgurl, option1txt, option2txt, option3txt, option4txt, option1pt, option2pt, option3pt, option4pt});

  factory QuestionModel.fromMap(map){
    return QuestionModel(
      uid: map['uid'],
      question: map['question'],
      option1txt: map['option1']['optext'],
      option1pt: map['option1']['points'],
      option2txt: map['option2']['optext'],
      option2pt: map['option2']['points'],
      option3txt: map['option3']['optext'],
      option3pt: map['option3']['points'],
      option4txt: map['option4']['optext'],
      option4pt: map['option4']['points'],
      widget: map['widget'],
      imgurl: map['imgurl'],
    );
  }

  
}