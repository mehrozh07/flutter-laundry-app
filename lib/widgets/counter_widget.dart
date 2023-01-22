import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/providers/cart_provider.dart';
import 'package:laundary_system/services/user_service.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import 'package:laundary_system/widgets/add_to_cart_widget.dart';
import 'package:provider/provider.dart';
import '../models/service_model.dart';


class CounterWidget extends StatefulWidget {
  final ServiceModel? service;
  final int? quantity;
  final String? docId;
  final String? productId;
  const CounterWidget({Key? key, this.service, this.quantity, this.docId, this.productId}) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  UserService userService = UserService();
  User? user = FirebaseAuth.instance.currentUser;

  bool loading = true;
  bool updating = false;
  int quantity = 1;
  bool exist = true;
  var total;



  @override
  void initState() {
    quantity = widget.quantity!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cartProvider = Provider.of<CartProvider>(context);
    return exist ?
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
              if(quantity ==1){
               cartProvider.deleteCart(widget.docId, context).then((value){
                 setState(() {
                   updating = true;
                   exist = false;
                 });
               });
               userService.checkCart(docId: widget.docId, context: context);
              }
              if(quantity>1){
                setState(() {
                  quantity--;
                });
              }
              var total = quantity*widget.service!.price!;
              userService.updateCart(widget.docId, quantity, total, context).then((value){
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
                 userService.updateCart(widget.docId, quantity, total, context);
                 updating = false;
              },
              icon: const Icon(CupertinoIcons.add)),
        ),
      ],
    ) :
    AddToCartWidget(
      service: widget.service,
    );
  }
}