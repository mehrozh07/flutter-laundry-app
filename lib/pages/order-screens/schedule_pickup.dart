// ignore_for_file: void_checks
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/bottom-app-bar/bottom_bar.dart';
import 'package:laundary_system/generated/assets.dart';
import 'package:laundary_system/providers/cart_provider.dart';
import 'package:laundary_system/providers/user_provider.dart';
import 'package:laundary_system/services/notification_service.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import '../../route_names.dart';
import 'package:laundary_system/services/user_service.dart';
import 'package:laundary_system/services/cart_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../location_screen/deliver_address.dart';
import '../location_screen/pickup_address.dart';

enum Payment{payPal, masterCard,cashOnDelivery}

class SchedulePickup extends StatefulWidget {
   const SchedulePickup({Key? key}) : super(key: key);

  @override
  State<SchedulePickup> createState() => _SchedulePickupState();
}

class _SchedulePickupState extends State<SchedulePickup> {
  var paymentType = Payment.cashOnDelivery;
  String? deviceToken;
   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  CartService cartService = CartService();
  UserService userService = UserService();
  final cardNumber = TextEditingController();
  final cardOnName = TextEditingController();
  final pickUpTime = TextEditingController();
  final deliveryTime = TextEditingController();
  String? pickedDate;
  // String? _category = 'mm';
  //
  //  final List<String> categoryList=["01", "02", "03","04","05", "06", "07", "08", "09", "10", "11", "12"];
  // void _onDropDownItemSelected(String? newSelectedBank) {
  //   setState(() {
  //     _category = newSelectedBank;
  //   });
  // }
  //
  // @override
  // void initState() {
  //  _category = categoryList[0];
  //   super.initState();
  // }
  DateTime? selectedDate;
  void getUserToken() async{
    await _firebaseMessaging.getToken().then((token){
      setState(() {
        deviceToken = token;
        if (kDebugMode) {
          print(deviceToken);
        }
      });
    });
  }

  @override
  void initState() {
    getUserToken();
    NotificationsService.initInfo(context);
    NotificationsService.requestPermission(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var cartProvider = Provider.of<CartProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    userProvider.getUserData();
    cartProvider.getSubTotal();
    userProvider.getAdminToken();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Scheduled A PickUp', style: Utils.appBarStyle,),
      ),
      bottomSheet: Container(
        height: height*0.1,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    color: Theme.of(context).primaryColor,
                    child: const Text('Confirm Order'),
                    onPressed: (){
                      if(userProvider.documentSnapshot?['pickUpLatitude'] == null){
                        return Utils.flushBarMessage(context, "please add your address", const Color(0xffED5050));
                      }else
                      if(userProvider.documentSnapshot?['pickUpLongitude'] == null){
                        return Utils.flushBarMessage(context, "please add your address", const Color(0xffED5050));
                      }else
                      if(userProvider.documentSnapshot?['deliveryLatitude'] == null){
                        return Utils.flushBarMessage(context, "please add your address", const Color(0xffED5050));
                      }else
                      if(userProvider.documentSnapshot?['deliveryLongitude'] == null){
                        return Utils.flushBarMessage(context, "please add your address", const Color(0xffED5050));
                      }else
                      if(userProvider.documentSnapshot?['pickupAddress'] == null){
                        return  Utils.flushBarMessage(context, "please add your address", const Color(0xffED5050));
                      }else
                      if(userProvider.documentSnapshot?['deliveryAddress'] == null){
                        return Utils.flushBarMessage(context, "please add your address", const Color(0xffED5050));
                      }else {
                        orderPlaced(
                          cartProvider: cartProvider,
                          paying: cartProvider.total,
                          context: context,
                          userProvider: userProvider,
                          token: deviceToken,
                      );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Text('Price details',style: Utils.boldTextStyle,),
          Card(
            color: const Color(0xffF9F9F9),
            child: Container(
              height: height*0.163,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal',style: Utils.simpleText),
                      Text('Rs.${cartProvider.total}',style: Utils.itemCount),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax',style: Utils.simpleText),
                      Text('Rs.10', style: Utils.itemCount),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',style: Utils.orderListName),
                      Text('Rs.${cartProvider.total+10}',style: Utils.headlineTextStyle),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height*0.02,),
          Text('Schedule Date',style: Utils.boldTextStyle,),
          SizedBox(height: height*0.01,),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: pickUpTime,
                  readOnly: true,
                  autofocus: true,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border:  OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    labelText: "Pickup Time",
                    prefixIcon: InkWell(
                        onTap: () async{
                          final  selectedRange0 = await showDatePicker(
                              context: context,
                              initialEntryMode: DatePickerEntryMode.calendar,
                              initialDate: DateTime.now(),
                              useRootNavigator: true,
                              routeSettings: const RouteSettings(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(3050),
                              builder: (context, Widget? child) => Theme(
                                data: ThemeData.light().copyWith(
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
                              )
                          );
                          if(selectedRange0 != null){
                            pickUpTime.text = selectedRange0.toString();
                            if (kDebugMode) {
                              print(pickUpTime.text);
                            }
                          }
                        },
                        child: const Icon(CupertinoIcons.calendar_badge_plus)),
                  ),
                ),
              ),
              SizedBox(width: width*0.02),
              Expanded(
                child: TextFormField(
                  controller: deliveryTime,
                  readOnly: true,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Delivery Time",
                    prefixIcon:InkWell(
                        onTap: () async{
                          final  selectedRange = await showDatePicker(
                            context: context,
                              initialEntryMode: DatePickerEntryMode.calendar,
                              initialDate: DateTime.now(),
                              useRootNavigator: true,
                              routeSettings: const RouteSettings(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(3050),
                              builder: (context, Widget? child) => Theme(
                                data: ThemeData.light().copyWith(
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
                          )
                          );
                          if(selectedRange != null){
                            deliveryTime.text = selectedRange.toString();
                            if (kDebugMode) {
                              print(deliveryTime.text);
                            }
                          }
                        },
                        child: const Icon(CupertinoIcons.calendar_today)),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: height*0.02,),
          Text('Payment method',style: Utils.boldTextStyle,),
          SizedBox(height: height*0.01,),
          Card(
            color: const Color(0xffF9F9F9),
            child: SizedBox(
              height: height*0.25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<Payment>(
                    visualDensity: const VisualDensity(vertical: -4.0),
                    activeColor: Theme.of(context).disabledColor.withOpacity(0.5),
                    secondary: const Icon(Icons.paypal),
                    selectedTileColor: Theme.of(context).disabledColor,
                    selected: false,
                    toggleable: false,
                    title: const Text("Pay Via Paypal"),
                    subtitle: Text("+ Add account",style: Utils.coloredTextStyle),
                    value: Payment.payPal,
                    groupValue: paymentType,
                    onChanged: (Payment? value) {
                      // setState(() {
                      //   paymentType = value!;
                      // });
                    },
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: RadioListTile<Payment>(
                      visualDensity: const VisualDensity(vertical: -4.0,),
                      activeColor: Theme.of(context).disabledColor.withOpacity(0.5),
                      secondary: Image.asset(Assets.assetsVisaLogo, height: 34, width: 34),
                      title: Text('Visa/Master Card', style: Utils.itemCount,),
                      subtitle: Text('**** **** **** 1234', style: Utils.coloredTextStyle,),
                      value: Payment.masterCard,
                      groupValue: paymentType,
                      onChanged: (Payment? value) {
                        // setState(() {
                        //   paymentType = value!;
                        // });
                      },
                    ),
                  ),
                  RadioListTile<Payment>(
                    visualDensity: const VisualDensity(vertical: -4.0,),
                    activeColor: Theme.of(context).primaryColor,
                    secondary: Image.asset(Assets.assetsCode,height: 54, width: 54),
                    selected: true,
                    title: Text('Cash On Delivery', style: Utils.itemCount,),
                    subtitle: Text("+ Add account",style: Utils.coloredTextStyle),
                    value: Payment.cashOnDelivery,
                    groupValue: paymentType,
                    onChanged: (Payment? value) {
                      setState(() {
                        paymentType = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height*0.02,),
          Text('Address',style: Utils.boldTextStyle,),
          Card(
            color: const Color(0xffF9F9F9),
            child: Container(
              height: height*0.3,
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Expanded(child: Icon(CupertinoIcons.circle, color: Colors.blue,)),
                      Expanded(
                        child: CustomPaint(
                            size: const Size(1, double.infinity),
                            painter: DashedLineVerticalPainter()
                        ),
                      ),
                      Expanded(child: Icon(CupertinoIcons.placemark, color: Theme.of(context).primaryColor,)),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context, CupertinoPageRoute(builder: (_)=> const PickUpAddress()));
                            },
                            title: Text('Pickup Address', style: Utils.itemCount),
                            subtitle: userProvider.documentSnapshot?['pickupAddress'] == null?
                            Text("Please Add PickUp Address", style: Utils.simpleTitleStyle) :
                            Text("${userProvider.documentSnapshot?['pickupAddress']}",
                              style: Utils.simpleTitleStyle,),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context, CupertinoPageRoute(
                                  builder: (_)=> const DeliverAddress()));
                            },
                            title: Text('Delivery Address', style: Utils.itemCount,),
                            subtitle: userProvider.documentSnapshot?['deliveryAddress'] == null?
                              Text("Please Add Delivery Address", style: Utils.simpleTitleStyle) :
                            Text('${userProvider.documentSnapshot?['deliveryAddress']}',
                              style: Utils.simpleTitleStyle,),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: height*0.1,),
        ],
      ),
    );
  }
  orderPlaced({required CartProvider cartProvider, paying, context, UserProvider? userProvider, token}){
    cartService.orderPlacing({
      "laundries": cartProvider.orderPlaced,
      "userId": FirebaseAuth.instance.currentUser?.uid,
      "customerPhone": FirebaseAuth.instance.currentUser?.phoneNumber,
      "totalPaying": paying,
      "pickupTime": Timestamp.fromDate(DateTime.parse(pickUpTime.text)),
      "deliveryTime": Timestamp.fromDate(DateTime.parse(deliveryTime.text)),
      "orderPlacingTime": DateTime.now(),
      "orderId": Random().nextInt(1000).toString(),
      "orderStatus": "Placed",
      "userDeviceToken": token,
      "orderConfirmTime": null,
      "orderPickupTime": null,
      "orderDeliveredTime": null,
      "orderProgressTime": null,
      "assignedDeliveryBoy": {
        "name": "",
        "phone": "",
        "location": "",
        "email": "",
      }
    }).then((value){
      userService.deleteCart().then((value){
        // userService.checkCart(docId: widget.docId, context: context);
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const BottomBar()));
        Utils.flushBarMessage(context, "Your Order has been placed successfully", Colors.green);
        NotificationsService.sendPushNotification(
          token: "${userProvider?.adminToken}",
          title: "Momy Laundry",
          body: "Congratulations! You just receive a new order!",
        );
      });
    });
  }
}
class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}