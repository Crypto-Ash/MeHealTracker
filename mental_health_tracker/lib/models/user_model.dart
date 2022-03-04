class UserModel {
  String? uid;
  String? email;
  String? name;
  String? contact;
  Map? userinfo;
  String? today;
  String? questionans;
  num? questionIndex;
  num? score;

  UserModel({this.uid, this.email, this.name, this.contact, this.userinfo, this.today, this.questionans, this.questionIndex, this.score});

  // recive data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      contact: map['contact'],
      userinfo: map['userinfo'],
      today: map['userinfo']['today'],
      questionans: map['userinfo']['questionans'],
      questionIndex: map['userinfo']['questionIndex'],
      score: map['userinfo']['Score'],
    );
  }

  

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'contact': contact,
      'userinfo': {
        'Score': score,
        'questionIndex': questionIndex,
        'today': today,
        'questionans': questionans,
      }
    };
  }
}