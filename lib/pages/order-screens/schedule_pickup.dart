import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/generated/assets.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import '../../route_names.dart';

class SchedulePickup extends StatefulWidget {
   SchedulePickup({Key? key}) : super(key: key);

  @override
  State<SchedulePickup> createState() => _SchedulePickupState();
}

class _SchedulePickupState extends State<SchedulePickup> {
  final cardNumber = TextEditingController();
  final cardOnName = TextEditingController();
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
                      Navigator.pushNamed(context, RoutesNames.orderDetails);
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
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Pickup Time",
                    prefixText: "Thu, 1 Apr \n 10 : 20 : 00",
                    prefixIcon: InkWell(
                        onTap: (){
                          showDateRangePicker(
                            context: context,
                              initialEntryMode: DatePickerEntryMode.calendar,
                              useRootNavigator: true,
                              routeSettings: const RouteSettings(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(3050),
                              builder: (context, Widget? child) => Theme(
                                data: ThemeData.dark().copyWith(
                                  //Header background color
                                  primaryColor: Theme.of(context).primaryColor,
                                  //Background color
                                  scaffoldBackgroundColor: Colors.grey[50],
                                  // //Divider color
                                  // dividerColor: Colors.grey,
                                  // //Non selected days of the month color
                                  textTheme: const TextTheme(
                                    bodyText2: TextStyle(color: Colors.black),
                                  ),
                                    colorScheme: ColorScheme.fromSwatch().copyWith(
                                      //Selected dates background color
                                      primary: Theme.of(context).primaryColor,
                                      //Month title and week days color
                                      onSurface: Theme.of(context).primaryColor,
                                      //Header elements and selected dates text color
                                      //onPrimary: Colors.white,
                                    ),
                                ),
                                child: child!,
                          ));
                         print('tapped');
                        },
                        child: const Icon(CupertinoIcons.calendar_badge_plus)),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Delivery Time",
                    prefixText: "Thu, 1 Apr \n 10 : 20 : 00",
                    prefixIcon:InkWell(
                        onTap: (){
                          showDateRangePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(3050),
                          );
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
                              Text('Card Number', style: Utils.appBarStyle,),
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
                                  // Text('Card Number', style: Utils.appBarStyle,),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        // Text('Card Number', style: Utils.appBarStyle,),
                                        Expanded(
                                          child: FormField<String>(
                                            // validator: (value){
                                            //   if(value!.isEmpty){
                                            //     return "*gender";
                                            //   }
                                            //   setState(() {
                                            //     _category = value;
                                            //   });
                                            //   return null;
                                            // },
                                            builder: (FormFieldState<String> state) {
                                              return InputDecorator(
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                    const EdgeInsets.fromLTRB(12, 10, 20, 20),
                                                    // errorText: "Wrong Choice",
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
                                        Expanded(
                                          child: FormField<String>(
                                            // validator: (value){
                                            //   if(value!.isEmpty){
                                            //     return "*gender";
                                            //   }
                                            //   setState(() {
                                            //     _category = value;
                                            //   });
                                            //   return null;
                                            // },
                                            builder: (FormFieldState<String> state) {
                                              return InputDecorator(
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                    const EdgeInsets.fromLTRB(12, 10, 20, 20),
                                                    // errorText: "Wrong Choice",
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
                                  ),
                                  // Text('Card Code', style: Utils.appBarStyle,),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Text('Card Code', style: Utils.appBarStyle,),
                                        FormField<String>(
                                          // validator: (value){
                                          //   if(value!.isEmpty){
                                          //     return "*gender";
                                          //   }
                                          //   setState(() {
                                          //     _category = value;
                                          //   });
                                          //   return null;
                                          // },
                                          builder: (FormFieldState<String> state) {
                                            return InputDecorator(
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                  const EdgeInsets.fromLTRB(12, 10, 20, 20),
                                                  // errorText: "Wrong Choice",
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
                                style: Utils.appBarStyle,),
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
                            onTap: (){},
                            title: Text('Pickup Address', style: Utils.itemCount,),
                            subtitle: Text('CT7B The Sparks, KDT Duong Noi, Str. Ha Dong,\n Ha Noi',
                              style: Utils.simpleTitleStyle,),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            onTap: (){},
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