import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:laundary_system/utils/Utils_widget.dart';

class UserService{
  User? user = FirebaseAuth.instance.currentUser;
  String collections = 'users';
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  CollectionReference cart = FirebaseFirestore.instance.collection("myCart");

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserById(String id) async{
    var result = await _firebaseFireStore.collection(collections).doc(id).get();
    return result;
  }
  Future<void> addToCart({name, image, id, price, serviceType}) {
    cart.doc(user?.uid).set({
      'users': user?.uid,
    });
    return cart.doc(user?.uid).collection('products').add({
      'productId': id,
      'name': name,
      'image': image,
      'price': price,
      "serviceType": serviceType,
      'quantity': 1,
      "cartId": user?.uid,
      "total": price,
    });
  }

  Future<void> updateCart(documentId, quantity, total, context) async{
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('myCart')
        .doc(user?.uid).collection('products').doc(documentId);
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      // Get the document
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        // Utils.flushBarMessage(context, "Item does not exist in cart!", const Color(0xffFF8C00));
        throw Exception("Product does not exist in cart!");
      }
      transaction.update(documentReference, {'quantity': quantity, 'total': total});
      return quantity;
    }).then((value) {
      Utils.flushBarMessage(context, "cart updated to $value!", const Color(0xff219653));
      if (kDebugMode) {
        print("Cart count updated to $value");
      }
    })
        .catchError((error) {
      // Utils.flushBarMessage(context, "Failed to update cart!", const Color(0xffFF8C00));
    });
  }
  Future<void> deleteCart() async{
    final result = await cart.doc(user?.uid).collection('products').get().then((value){
      for(DocumentSnapshot ds in value.docs){
        ds.reference.delete();
      }
    });
  }

  Future<void> checkCart({docId,context}) async{
    final snapShot = await cart.doc(user?.uid).collection('products').get();
    if(snapShot.docs.isEmpty){
      cart.doc(user?.uid).delete().then((value){
        Utils.flushBarMessage(context, "oppss! You cart is empty now!", const Color(0xffED5050));
      });
    }
  }



}