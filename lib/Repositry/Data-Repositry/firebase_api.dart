import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi{

  CollectionReference user = FirebaseFirestore.instance.collection('users');
}