import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laundary_system/models/service_model.dart';
import 'package:laundary_system/services/user_service.dart';

class CartService{
  CollectionReference order = FirebaseFirestore.instance.collection('orders');
  UserService userService = UserService();
  Future<DocumentReference> orderPlacing(Map<String, dynamic> data){
    var snapshot = order.add(data);
    return snapshot;
  }
   User? user = FirebaseAuth.instance.currentUser;
   ServiceModel serviceModel = ServiceModel();

}