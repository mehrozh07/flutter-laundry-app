import 'package:cloud_firestore/cloud_firestore.dart';

class UserService{
  String collections = 'users';
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserById(String id) async{
    var result = await _firebaseFireStore.collection(collections).doc(id).get();
    return result;
  }
}