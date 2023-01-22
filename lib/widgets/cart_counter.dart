import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laundary_system/models/service_model.dart';
import 'package:laundary_system/providers/cart_provider.dart';
import 'package:laundary_system/services/user_service.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import 'package:provider/provider.dart';

class CartCounter extends StatefulWidget {
  final ServiceModel? service;
  const CartCounter({Key? key, this.service}) : super(key: key);

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  UserService userService = UserService();
  User? user = FirebaseAuth.instance.currentUser;
  bool loading = true;
  bool updating = false;
  var total;

  getCartData() async{
    var snapShot  = await userService.cart.doc(user?.uid).collection('products').get();
    if(snapShot.docs.isEmpty){
      setState(() {
        loading = false;
      });
    }else{
      setState(() {
        loading = false;
      });
    }
  }
  bool exist = false;
  int quantity = 1;
  String? docId;
  String? name;
  getData(){
    FirebaseFirestore.instance
        .collection('myCart').doc(user?.uid).collection('products')
        .where('productId', isEqualTo: widget.service?.productId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if(mounted){
          if(doc['productId'] == widget.service?.productId){
            setState(() {
              exist = true;
              quantity = doc['quantity'];
              // name = doc['name'];
              docId = doc.id;
            });
          }
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cartProvider = Provider.of<CartProvider>(context);
    return exist?
      Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              side: const BorderSide(
                color: Color(0xffC3C8D2),
              ),
            ),
            onPressed: (){
              setState(() {
                updating = true;
              });
              if (quantity == 1) {
                cartProvider.deleteCart(widget.service?.productId, context).then((value){
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
              var total = quantity*widget.service!.price!;
              userService.updateCart(docId, quantity, total, context).then((value){
                setState(() {
                  updating = true;
                });
              });
            },
            icon: const Icon(CupertinoIcons.minus),
          ),
        ),
        SizedBox(width: width*0.01,),
        Text('$quantity',style: Utils.itemCount,),
        SizedBox(width: width*0.01),
        SizedBox(
          height: 24,
          width: 24,
          child: IconButton(
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
                total = quantity * widget.service!.price!;
                userService.updateCart(docId, quantity, total, context);
                updating = false;
              },
              icon: const Icon(CupertinoIcons.add)),
        ),
      ],
    ) :
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              side: const BorderSide(
                color: Color(0xffC3C8D2),
              ),
            ),
            onPressed: null,
            icon: const Icon(CupertinoIcons.minus),
          ),
        ),
        SizedBox(width: width*0.01,),
        Text('0', style: Utils.itemCount,),
        SizedBox(width: width*0.01),
        SizedBox(
          height: 24,
          width: 24,
          child: IconButton(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                side: const BorderSide(
                  color: Color(0xffC3C8D2),
                ),
              ),
              onPressed: (){
                userService.addToCart(
                    name: widget.service?.name,
                    image: widget.service?.image,
                    id: widget.service?.productId,
                    price: widget.service?.price,
                    serviceType: widget.service?.serviceType)
                    .then((snapshot) {
                  Utils.flushBarMessage(context, "Item added to cart", const Color(0xff219653));
                });
                setState(() {
                  exist = true;
                });
              },
              icon: const Icon(CupertinoIcons.add)),
        ),
      ],
    ) ;
  }
}
