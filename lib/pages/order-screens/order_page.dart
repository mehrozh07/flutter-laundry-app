import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/Repositry/Shimmer/shimmer_effect.dart';
import 'package:laundary_system/pages/order-screens/order_details.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatelessWidget {
   OrderPage({Key? key}) : super(key: key);
  ShimmerEffect shimmerEffect = ShimmerEffect();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE5E5E5),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('orders')
              .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if(snapshot.data?.size == 0 ){
              return const Center(child: Text('You have no orders yet'));
            }
            if (!snapshot.hasData) {
              return shimmerEffect.shimmer();
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return Padding(
                  padding: const EdgeInsets.only(left: 6,right: 6, top: 8, bottom: 8),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=> OrderDetails(
                        snapshot: document,
                      )));
                    },
                    child: Container(
                      height: height*0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffF9F9F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(CupertinoIcons.time, size: 41, color: Color(0xffF39738),),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ListTile(
                                  dense: true,
                                  visualDensity: const VisualDensity(horizontal: -4),
                                  contentPadding: EdgeInsets.zero,
                                  title: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Text("Order #${document['orderId']}", style: Utils.blackBoldStyle,),
                                      Text("(${document['laundries'].length} bags)", style: Utils.simpleTitleStyle,),
                                    ],
                                  ),
                                  trailing: Text("Rs.${document['totalPaying']}", style: Utils.headlineTextStyle,),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(DateFormat("hh:mm").format(document['pickupTime'].toDate()),
                                          style: Utils.boldTextStyle,),
                                        Text(DateFormat("MMM d, yyyy").format(document['pickupTime'].toDate()),
                                            style: Utils.textSubtitle),
                                      ],
                                    ),
                                    Container(
                                      width: width*0.35,
                                      height: 30,
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.circle_outlined, size: 14, color: Theme.of(context).primaryColor,),
                                          CustomPaint(
                                              painter: DrawDottedhorizontalline()
                                          ),
                                          Icon(Icons.circle,size: 14, color: Theme.of(context).primaryColor),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(DateFormat("hh:mm").format(document['deliveryTime'].toDate()),
                                          style: Utils.boldTextStyle,),
                                        Text(DateFormat("MMM d, yyyy").format(document['deliveryTime'].toDate()),
                                            style: Utils.textSubtitle),
                                      ],
                                    ),
                                  ],
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
class DrawDottedhorizontalline extends CustomPainter {
  Paint? _paint;
  DrawDottedhorizontalline() {
    _paint = Paint();
    _paint!.color = Colors.black; //dots color
    _paint!.strokeWidth = 2; //dots thickness
    _paint!.strokeCap = StrokeCap.square; //dots corner edges
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -50; i < 50; i = i + 3) {
      // 15 is space between dots
      if (i % 2 == 0) {
        canvas.drawLine(Offset(i, 0.0), Offset(i + 0.5, 0.0), _paint!);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}