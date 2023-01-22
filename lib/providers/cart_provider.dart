import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/models/cart_model.dart';
import 'package:laundary_system/models/service_model.dart';
import 'package:laundary_system/utils/Utils_widget.dart';

class CartProvider extends ChangeNotifier{
  CollectionReference db = FirebaseFirestore.instance.collection('cartData');
  User? user = FirebaseAuth.instance.currentUser;
  // Future<void> addReviewCart({
  //   required String? itemId,
  //   required String? itemName,
  //   required String? itemImage,
  //   required int? itemPrice,
  //   required int? itemQuantity,
  //   required String? genderType,
  //   required String? serviceType,
  //
  // }) async {
  //   CartModel reviewCartModel = CartModel(
  //     cartId: itemId,
  //     cartName: itemName,
  //     cartPrice: itemPrice,
  //     cartImage: itemImage,
  //     cartQuantity: itemQuantity,
  //     genderType: genderType,
  //     serviceType: serviceType,
  //     idAdd: true,
  //   );
  //   await db.doc(user?.uid).collection('myCart').doc(itemId).set(reviewCartModel.toJson());
  // }
  // final List<ServiceModel> _cartList = [];
  // List<ServiceModel> get cartList => _cartList;

   double total = 0.0;
  double totalQuantity = 0;
  getSubTotal() {
    double cartTotal = 0;
    double quantities = 0;
    FirebaseFirestore.instance
        .collection('myCart').doc(user?.uid).collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        cartTotal = cartTotal+doc['total'];
        quantities = quantities + doc['quantity'];
        notifyListeners();
      }
      total = cartTotal;
      totalQuantity =quantities;
      notifyListeners();
      return cartTotal;
    });
  }

  Future<void> deleteCart(cartId, context) async{
    await FirebaseFirestore.instance.collection('myCart')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('products')
        .doc(cartId).delete().then((value){
      Utils.flushBarMessage(context, "Item deleted from cart!", const Color(0xffFF8C00));});
    notifyListeners();
  }
}