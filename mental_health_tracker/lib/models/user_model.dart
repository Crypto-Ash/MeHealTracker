class UserModel {
  String? uid;
  String? email;
  String? name;
  String? contact;
  Map? userinfo;
  String? today;
  String? questionans;

  UserModel({this.uid, this.email, this.name, this.contact, this.userinfo, this.today, this.questionans});

  // recive data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      contact: map['contact'],
      userinfo: map['userinfo'],
      today: map['userinfo.today'],
      questionans: map['userinfo.questionans'],
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
        'today': today,
        'questionans': questionans,
      }
    };
  }
}