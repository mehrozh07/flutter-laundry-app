import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/pages/cart-screen/cart_widget.dart';
import 'package:laundary_system/providers/service_provider.dart';
import 'package:laundary_system/route_names.dart';
import 'package:laundary_system/widgets/add_to_cart_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../providers/cart_provider.dart';
import '../../services/user_service.dart';
import '../../utils/Utils_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  UserService userService = UserService();
  User? user = FirebaseAuth.instance.currentUser;
  String? _category = '';

  final List<String> categoryList=["Men", "Woman", "Kid"];
  void _onDropDownItemSelected(String? newSelectedBank) {
    setState(() {
      _category = newSelectedBank;
    });
  }
  @override
  void initState() {
    _category = categoryList[0];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var text = MediaQuery.textScaleFactorOf(context);
    var serviceProvider = Provider.of<ServiceProvider>(context);
    serviceProvider.getService();
    var cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getSubTotal();
    cartProvider.confirmOrder();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        bottomSheet: cartProvider.totalQuantity != 0?
        Container(
          height: height*0.19,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 8,
                  spreadRadius: 0.6,
                  offset: Offset(0.1, 0.1),
                )
              ],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                topRight: Radius.circular(10),)
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(horizontal: -4),
                  leading: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(horizontal: -4),
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.15),
                      shape: const CircleBorder(),
                    ),
                    child: Icon(
                      CupertinoIcons.cube,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                  ),
                  title: Text('Total', style: Utils.subtitle),
                  subtitle: Text('${cartProvider.totalQuantity}',
                    style: TextStyle(
                      fontSize: text*18,
                      color: const Color(0xff292929),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Cost', style: Utils.subtitle),
                      Text('Rs.${cartProvider.total}',
                          style: Utils.headlineTextStyle),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: AbsorbPointer(
                        absorbing: cartProvider.totalQuantity == 0.0 ? true : false,
                        child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            color: cartProvider.totalQuantity == 0.0 ?
                            Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor,
                            child: const Text('Confirm Order'),
                            onPressed: (){
                              Navigator.pushNamed(context, RoutesNames.scheduledPickUp);
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ) : Container(),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('myCart').doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('products')
              .where('cartId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (!snapshot.hasData) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 48.0,
                                  height: 48.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: 40.0,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 6,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            if(snapshot.data!.docs.isEmpty){
              return const Center(child: Text("Your Cart is Empty"));
            }
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return CartWidget(document: document);
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
