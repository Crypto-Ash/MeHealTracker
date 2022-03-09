class QuestionModel {
  String question;
  String option1txt;
  String option2txt;
  String option3txt;
  String option4txt;
  num option1pt;
  num option2pt;
  num option3pt;
  num option4pt;
  String widget;
  num uid;
  String imgurl;
  Map option1;
  Map option2;
  Map option3;
  Map option4;
  //dont use null operator in models it will affect you 

  QuestionModel({required this.uid, required this.question, required this.widget, required this.option1, required this.option2, required this.option3, required this.option4, required this.imgurl, required this.option1txt, required this.option2txt, required this.option3txt, required this.option4txt, required this.option1pt, required this.option2pt, required this.option3pt, required this.option4pt});

  factory QuestionModel.fromMap(map){
    return QuestionModel(
      uid: map['uid'],
      question: map['question'],
      option1: map['option1'],
      option2: map['option2'],
      option3: map['option3'],
      option4: map['option4'],
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