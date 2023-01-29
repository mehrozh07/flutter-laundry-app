import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/models/cart_model.dart';
import 'package:laundary_system/models/service_model.dart';
import 'package:laundary_system/utils/Utils_widget.dart';

class CartProvider extends ChangeNotifier{
  CollectionReference db = FirebaseFirestore.instance.collection('cartData');
  User? user = FirebaseAuth.instance.currentUser;

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
  List _confirmOrder = [];
  List get orderPlaced => _confirmOrder;

  Future<void> confirmOrder() async{
  List saveOrder = [];
  FirebaseFirestore.instance
      .collection('myCart').doc(user?.uid).collection('products')
      .get()
      .then((QuerySnapshot querySnapshot) {
        for(var doc in querySnapshot.docs){
        if(!saveOrder.contains(doc.data())){
          saveOrder.add(doc.data());
          _confirmOrder = saveOrder;
          notifyListeners();
          }
        }
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

  Future pickDateRange(context, dateTime) async{
     DateTimeRange? newDateRange = await showDateRangePicker(
         context: context,
         initialEntryMode: DatePickerEntryMode.calendar,
         useRootNavigator: true,
         // routeSettings: const RouteSettings(),
         initialDateRange: dateTime,
         firstDate: DateTime.now(),
         lastDate: DateTime(DateTime.now().year + 1),
         builder: (context, Widget? child) => Theme(
           data: ThemeData.dark().copyWith(
             primaryColor: Theme.of(context).primaryColor,
             scaffoldBackgroundColor: Colors.grey.shade50,
             textTheme: const TextTheme(
               bodyMedium: TextStyle(color: Colors.black),
             ),
             colorScheme: ColorScheme.fromSwatch().copyWith(
               primary: Theme.of(context).primaryColor,
               onSurface: Theme.of(context).primaryColor,
             ),
           ),
           child: child!,
         ),
     );
     if(newDateRange == null){
       return; //if cancel
     }else{
       dateTime = newDateRange;
       notifyListeners();
     }
  }

   QueryDocumentSnapshot? _snapshot;
  QueryDocumentSnapshot?  get snapshot => _snapshot;
  getCartDetails() {
    FirebaseFirestore.instance
        .collection('orders').where('userId', isEqualTo: user?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        _snapshot = doc;
        notifyListeners();
      }
    });
  }
}