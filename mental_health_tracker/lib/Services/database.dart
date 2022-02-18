import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  getQuestionData(String id) async{
    return await FirebaseFirestore.instance
    .collection('Questions')
    .get();
  }
}