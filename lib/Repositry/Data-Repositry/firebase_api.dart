import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseApi{
  User? uid = FirebaseAuth.instance.currentUser;
  CollectionReference user = FirebaseFirestore.instance.collection('users');
}