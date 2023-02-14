import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laundary_system/models/service_model.dart';
import 'package:laundary_system/providers/cart_provider.dart';
import 'package:laundary_system/services/user_service.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import 'package:provider/provider.dart';

import '../services/cart_service.dart';

class CartCounter extends StatefulWidget {
  final DocumentSnapshot snapshot;
  const CartCounter({Key? key,required this.snapshot}) : super(key: key);

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  User? user = FirebaseAuth.instance.currentUser;
  UserService userService = UserService();
  int quantity = 1;
  bool exist = false;
  bool updating = false;
  CartService cartService = CartService();
  String? docId;
  var total;

  void getCart() async {
    FirebaseFirestore.instance
        .collection('myCart')
        .doc(user?.uid)
        .collection('products')
        .where('productId', isEqualTo: widget.snapshot['productId'])
        .get()
        .then((QuerySnapshot querySnapshot) {
      if(mounted){
        if(querySnapshot.docs.isNotEmpty){
          for (var doc in querySnapshot.docs) {
            if (doc['productId'] == widget.snapshot['productId']) {
              setState(() {
                quantity = doc['quantity'];
                docId = doc.id;
                exist = true;
              });
            }
          }
        }else{
          setState(() {
            exist = false;
          });
        }
      }
    });
  }
  @override
  void initState() {
    getCart();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cartProvider = Provider.of<CartProvider>(context);
      return exist == true ?
      Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: FilledButton.tonal(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              side: const BorderSide(
                color: Color(0xffC3C8D2),
              ),
            ),
            onPressed: (){
              setState(() {
                exist = true;
              });
              if (quantity == 1) {
                cartProvider.deleteCart(widget.snapshot.id, context).then((value){
                  setState(() {
                    updating = true;
                    exist = false;
                  });
                });
                userService.checkCart(docId: docId, context: context);
              }
              if(quantity>1){
                setState(() {
                  quantity--;
                });
              }
              var total = quantity*widget.snapshot['price']!;
              userService.updateCart(docId, quantity, total, context).then((value){
                if(mounted){
                  setState(() {
                    updating = true;
                  });
                }
              });
            },
            child: const Icon(CupertinoIcons.minus),
          ),
        ),
        SizedBox(width: width*0.01,),
        Text('$quantity',
          style: Utils.itemCount,),
        SizedBox(width: width*0.01),
        SizedBox(
          height: 24,
          width: 24,
          child: FilledButton.tonal(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                side: const BorderSide(
                  color: Color(0xffC3C8D2),
                ),
              ),
              onPressed: (){
                setState(() {
                  updating = true;
                  quantity++;
                });
                total = quantity * widget.snapshot['price'];
                userService.updateCart(docId, quantity, total, context);
                updating = false;
              },
              child: const Icon(CupertinoIcons.add)),
        ),
      ],
    ) :
      const Icon(CupertinoIcons.add);

  }
}
