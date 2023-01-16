import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{

  DocumentSnapshot? documentSnapshot;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DocumentSnapshot> getUserData() async{
    DocumentSnapshot result = await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser?.uid).get();
    documentSnapshot = result;
    notifyListeners();
    return result;
  }
}