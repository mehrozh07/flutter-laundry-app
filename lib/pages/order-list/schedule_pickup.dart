import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/generated/assets.dart';
import 'package:laundary_system/utils/Utils_widget.dart';

class SchedulePickup extends StatelessWidget {
  const SchedulePickup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                      // Navigator.pushNamed(context, RoutesNames.scheduledPickUp);
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
                      Text('\$220.23',style: Utils.itemCount),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax',style: Utils.simpleText),
                      Text('\$10',style: Utils.itemCount),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',style: Utils.orderListName),
                      Text('\$230.23',style: Utils.headlineTextStyle),
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
                  readOnly: true,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Pickup Time",
                    prefixText: "Thu, 1 Apr \n 10 : 20 : 00",
                    prefixIcon: Icon(CupertinoIcons.calendar_badge_plus),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Delivery Time",
                    prefixText: "Thu, 1 Apr \n 10 : 20 : 00",
                    prefixIcon: Icon(CupertinoIcons.calendar_today),
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
                            title: Text('Pickup Address', style: Utils.itemCount,),
                            subtitle: Text('CT7B The Sparks, KDT Duong Noi, Str. Ha Dong,\n Ha Noi',
                              style: Utils.simpleTitleStyle,),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
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