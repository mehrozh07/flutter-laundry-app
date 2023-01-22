import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/services/user_service.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import 'package:laundary_system/widgets/counter_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../models/service_model.dart';

class AddToCartWidget extends StatefulWidget {
  final ServiceModel? service;
  final String? productId;
  const AddToCartWidget({Key? key, this.service, this.productId})
      : super(key: key);

  @override
  State<AddToCartWidget> createState() => _AddToCartWidgetState();
}

class _AddToCartWidgetState extends State<AddToCartWidget> {
  UserService userService = UserService();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    getCartData();
    super.initState();
  }

  getCartData() async {
    var snapShot = await userService.cart.doc(user?.uid).collection('products').get();
    if (mounted) {
      if (snapShot.docs.isEmpty) {
        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    }
  }

  bool loading = true;
  bool exist = false;
  int quantity = 1;
  String? docId;
  getData() {
    FirebaseFirestore.instance
        .collection('myCart')
        .doc(user?.uid)
        .collection('products')
        .where('productId', isEqualTo: widget.service?.productId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (mounted) {
          if (doc['productId'] == widget.service?.productId) {
            setState(() {
              exist = true;
              quantity = doc['quantity'];
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
    getData();
    return loading
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Row(
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
                SizedBox(
                  width: width * 0.01,
                ),
                Text('0',
                  style: Utils.itemCount,
                ),
                SizedBox(width: width * 0.01),
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
                      icon: const Icon(CupertinoIcons.add)),
                ),
              ],
            )) : exist
            ? CounterWidget(
                quantity: quantity,
                service: widget.service,
                docId: docId,
                productId: widget.service?.productId,
              )
            : Row(
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
                  SizedBox(
                    width: width * 0.01,
                  ),
                  Text(
                    '0',
                    style: Utils.itemCount,
                  ),
                  SizedBox(width: width * 0.01),
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
                        onPressed: () {
                          userService
                              .addToCart(
                                  name: widget.service?.name,
                                  image: widget.service?.image,
                                  id: widget.service?.productId,
                                  price: widget.service?.price,
                                  serviceType: widget.service?.serviceType)
                              .then((value) {
                            Utils.flushBarMessage(context, "Item added to cart",
                                const Color(0xff219653));
                          });
                          exist = true;
                        },
                        icon: const Icon(CupertinoIcons.add)),
                  ),
                ],
              );
  }
}
