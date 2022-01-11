class UserModel {
  String? uid;
  String? email;
  String? name;
  String? contact;

  UserModel({this.uid, this.email, this.name, this.contact});

  // recive data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      contact: map['contact'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'contact': contact,
    };
  }
}