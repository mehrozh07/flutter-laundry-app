import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:laundary_system/models/service_model.dart';

class CartService{
   User? user = FirebaseAuth.instance.currentUser;
   ServiceModel serviceModel = ServiceModel();
   double total = 0.0;

   getSubTotal() {
     double total = 0.0;
     FirebaseFirestore.instance
         .collection('myCart').doc(user?.uid).collection('products')
         .get()
         .then((QuerySnapshot querySnapshot) {
       for (var doc in querySnapshot.docs) {
         total += doc['price'] * doc['quantity'];
         if (kDebugMode) {
           print(total);
         }
       }
       return total;
     });
   }
}