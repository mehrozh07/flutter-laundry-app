import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/generated/assets.dart';
import 'package:laundary_system/providers/cart_provider.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import '../../route_names.dart';
import 'package:laundary_system/services/user_service.dart';
import 'package:laundary_system/services/cart_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../location_screen/deliver_address.dart';
import '../location_screen/pickup_address.dart';

class SchedulePickup extends StatefulWidget {
   SchedulePickup({Key? key}) : super(key: key);

  @override
  State<SchedulePickup> createState() => _SchedulePickupState();
}

class _SchedulePickupState extends State<SchedulePickup> {
  CartService cartService = CartService();
  UserService userService = UserService();
  final cardNumber = TextEditingController();
  final cardOnName = TextEditingController();
  final pickUpTime = TextEditingController();
  final deliveryTime = TextEditingController();
  String? pickedDate;

  String? _category = 'mm';

   final List<String> categoryList=["01", "02", "03","04","05", "06", "07", "08", "09", "10", "11", "12"];
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
  DateTime? selectedDate;
  _selectDate() async{
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2024),
        builder: (context, Widget? child) => Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).primaryColor,
            scaffoldBackgroundColor: Colors.grey.shade200,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.black54),
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Theme.of(context).primaryColor,
              onSurface: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        ),
    );
    if(date != null){
      setState(() {
        selectedDate = date;
        pickedDate = DateFormat.yMd('en_US').add_jm().format(selectedDate!);
        print(pickedDate);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getSubTotal();

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
                      orderPlaced(cartProvider: cartProvider, paying: cartProvider.total, context: context);
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
                    // prefixText: "${startDate.day},${startDate.month},${startDate.month} "
                    //     "\n 10 : 20 : 00",
                    prefixIcon: InkWell(
                        onTap: () async{
                          final  _selectedRange = await showDatePicker(
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
                          if(_selectedRange != null){
                            pickUpTime.text = DateFormat.yMMMd('en_US').add_jm().format(_selectedRange);
                            print(_selectedRange);
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
                            deliveryTime.text = DateFormat.yMMMd('en_US').add_jm().format(selectedRange);
                            print(selectedRange);
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
                  ListTile(
                    dense: true,
                    visualDensity: const VisualDensity(horizontal: -4),
                    leading: const Icon(CupertinoIcons.chevron_down_circle),
                    title: Text('Pay Via Paypal', style: Utils.itemCount,),
                    subtitle: Text('+ Add account', style: Utils.coloredTextStyle,),
                    trailing: Image.asset(Assets.assetsPaypal),
                  ),
                  ListTile(
                    dense: true,
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              )),
                          builder: (context){
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                 title: Text(
                                  'Add Visa/Master Card',
                                  style: Utils.orderListName,
                                ),
                                trailing: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(Icons.close)),
                              ),
                              const Divider(thickness: 2,),
                              Text('Card Number', style: Utils.masterCard,),
                              TextFormField(
                                controller: cardNumber,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'enter card number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Card number",
                                  prefixIcon: const Icon(CupertinoIcons.creditcard),
                                  contentPadding: EdgeInsets.only(left: width * 0.03, right: 0, top: 0, bottom: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color(0xffE9EBF0),
                                    ),
                                  ),
                                  fillColor: const Color(0xffF3F3F3),
                                  filled: true,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            Text('Card Number ', style: Utils.masterCard,),
                                            Text('(Month - year)', style: Utils.textSubtitle,),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            //
                                            Expanded(
                                              child: FormField<String>(
                                                builder: (FormFieldState<String> state) {
                                                  return InputDecorator(
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.only(left: width * 0.04, right: 0, top: 0, bottom: 0),
                                                        errorStyle: const TextStyle(
                                                            color: Colors.redAccent, fontSize: 16.0),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10.0)),
                                                    ),
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton<String>(
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey,
                                                        ),
                                                        hint: const Text(
                                                          "mm",
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        items: categoryList
                                                            .map<DropdownMenuItem<String>>(
                                                                (String? value) {
                                                              return DropdownMenuItem(
                                                                value: value,
                                                                child: Row(
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),
                                                                    Text(value!),
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList(),

                                                        isExpanded: true,
                                                        isDense: true,
                                                        onChanged: (String? newSelectedBank) {
                                                          _onDropDownItemSelected(newSelectedBank);
                                                        },
                                                        value: _category,

                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(width: width*0.02),
                                            Expanded(
                                              child: FormField<String>(
                                                builder: (FormFieldState<String> state) {
                                                  return InputDecorator(
                                                    decoration: InputDecoration(
                                                        contentPadding: EdgeInsets.only(left: width * 0.04, right: 0, top: 0, bottom: 0),
                                                        errorStyle: const TextStyle(
                                                            color: Colors.redAccent, fontSize: 16.0),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10.0))),
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton<String>(
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey,
                                                        ),
                                                        hint: const Text(
                                                          "mm",
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        items: categoryList
                                                            .map<DropdownMenuItem<String>>(
                                                                (String? value) {
                                                              return DropdownMenuItem(
                                                                value: value,
                                                                child: Row(
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),
                                                                    Text(value!),
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList(),

                                                        isExpanded: true,
                                                        isDense: true,
                                                        onChanged: (String? newSelectedBank) {
                                                          _onDropDownItemSelected(newSelectedBank);
                                                        },
                                                        value: _category,

                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: width*0.02),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Text('Card Code', style: Utils.masterCard),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(left: width * 0.04, right: 0, top: 0, bottom: 0),
                                              hintText: "CVC",
                                              errorStyle: const TextStyle(
                                                  color: Colors.redAccent, fontSize: 16.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Text('Name on Card',
                                textAlign: TextAlign.start,
                                style: Utils.masterCard),
                              TextFormField(
                                controller: cardOnName,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please your name on card';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Please your name on card",
                                  // prefixIcon: const Icon(CupertinoIcons.creditcard),
                                  contentPadding: EdgeInsets.only(left: width * 0.04, right: 0, top: 0, bottom: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color(0xffE9EBF0),
                                      width: 0.5,
                                    ),
                                  ),
                                  fillColor: const Color(0xffF3F3F3),
                                  filled: true,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      color: Theme.of(context).primaryColor,
                                      child: const Text("Save & Continue"),
                                      onPressed: (){},
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                    },
                    visualDensity: const VisualDensity(horizontal: -4),
                    leading: const Icon(CupertinoIcons.chevron_down_circle),
                    title: Text('Visa/Master Card', style: Utils.itemCount,),
                    subtitle: Text('**** **** **** 1234', style: Utils.coloredTextStyle,),
                    trailing: Image.asset(Assets.assetsVisaLogo, height: 34, width: 34,),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: const VisualDensity(horizontal: -4),
                    leading: const Icon(CupertinoIcons.chevron_down_circle),
                    title: Text('Cash On Delivery', style: Utils.itemCount,),
                    trailing: Image.asset(Assets.assetsCode,height: 54, width: 54,),
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
                              if(Platform.isAndroid){
                                Navigator.push(context, CupertinoPageRoute(builder: (_)=> const PickUpAddress()));
                              }else{
                                Utils.flushBarMessage(context, 'not enabled for ios', Colors.red);
                              }
                            },
                            title: Text('Pickup Address', style: Utils.itemCount,),
                            subtitle: Text('CT7B The Sparks, KDT Duong Noi, Str. Ha Dong,\n Ha Noi',
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
                            subtitle: Text('CT7B The Sparks, KDT Duong Noi, Str. Ha Dong,\n Ha Noi',
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
  orderPlaced({required CartProvider cartProvider, paying, context}){
    cartService.orderPlacing({
      "laundries": cartProvider.orderPlaced,
      "userId": FirebaseAuth.instance.currentUser?.uid,
      "customerPhone": FirebaseAuth.instance.currentUser?.phoneNumber,
      "totalPaying": paying,
      "pickupTime": pickUpTime.text,
      "deliveryTime": deliveryTime.text,
      "orderPlacingTime": DateTime.now(),
      "orderStatus": "Placed",
      "assignedDeliveryBoy": {
        "name": "",
        "phone": "",
        "location": "",
        "email": "",
      }
    }).then((value){
      userService.deleteCart().then((value){
        // userService.checkCart(docId: widget.docId, context: context);
        Navigator.pushReplacementNamed(context, RoutesNames.orderDetails);
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