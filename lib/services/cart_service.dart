import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundary_system/models/service_model.dart';
import 'package:laundary_system/services/user_service.dart';
import 'package:flutter/material.dart';

import '../utils/Utils_widget.dart';



class CartService{
  CollectionReference order = FirebaseFirestore.instance.collection('orders');
  UserService userService = UserService();
  Future<DocumentReference> orderPlacing(Map<String, dynamic> data){
    var snapshot = order.add(data);
    return snapshot;
  }
   User? user = FirebaseAuth.instance.currentUser;
   ServiceModel serviceModel = ServiceModel();
   
  // Future<void> payPal(context){
  //   var height = MediaQuery.of(context).size.height;
  //   var width = MediaQuery.of(context).size.width;
  //
  //   return  showModalBottomSheet(
  //       context: context,
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //             topRight: Radius.circular(20),
  //             topLeft: Radius.circular(20),
  //           )),
  //       builder: (context){
  //         return Padding(
  //           padding: const EdgeInsets.only(left: 8, right: 8),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               ListTile(
  //                 contentPadding: EdgeInsets.zero,
  //                 title: Text(
  //                   'Add Visa/Master Card',
  //                   style: Utils.orderListName,
  //                 ),
  //                 trailing: TextButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: const Icon(Icons.close)),
  //               ),
  //               const Divider(thickness: 2,),
  //               Text('Card Number', style: Utils.masterCard,),
  //               TextFormField(
  //                 keyboardType: TextInputType.number,
  //                 validator: (value) {
  //                   if (value!.isEmpty) {
  //                     return 'enter card number';
  //                   }
  //                   return null;
  //                 },
  //                 decoration: InputDecoration(
  //                   hintText: "Card number",
  //                   prefixIcon: const Icon(CupertinoIcons.creditcard),
  //                   contentPadding: EdgeInsets.only(left: width * 0.03, right: 0, top: 0, bottom: 0),
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                     borderSide: const BorderSide(
  //                       color: Color(0xffE9EBF0),
  //                     ),
  //                   ),
  //                   fillColor: const Color(0xffF3F3F3),
  //                   filled: true,
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: height * 0.03,
  //               ),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     flex: 2,
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Wrap(
  //                           crossAxisAlignment: WrapCrossAlignment.center,
  //                           children: [
  //                             Text('Card Number ', style: Utils.masterCard,),
  //                             Text('(Month - year)', style: Utils.textSubtitle,),
  //                           ],
  //                         ),
  //                         Row(
  //                           children: [
  //                             //
  //                             Expanded(
  //                               child: FormField<String>(
  //                                 builder: (FormFieldState<String> state) {
  //                                   return InputDecorator(
  //                                     decoration: InputDecoration(
  //                                       contentPadding: EdgeInsets.only(left: width * 0.04, right: 0, top: 0, bottom: 0),
  //                                       errorStyle: const TextStyle(
  //                                           color: Colors.redAccent, fontSize: 16.0),
  //                                       border: OutlineInputBorder(
  //                                           borderRadius:
  //                                           BorderRadius.circular(10.0)),
  //                                     ),
  //                                     child: DropdownButtonHideUnderline(
  //                                       child: DropdownButton<String>(
  //                                         style: const TextStyle(
  //                                           fontSize: 16,
  //                                           color: Colors.grey,
  //                                         ),
  //                                         hint: const Text(
  //                                           "mm",
  //                                           style: TextStyle(
  //                                             color: Colors.grey,
  //                                             fontSize: 16,
  //                                           ),
  //                                         ),
  //                                         items: categoryList
  //                                             .map<DropdownMenuItem<String>>(
  //                                                 (String? value) {
  //                                               return DropdownMenuItem(
  //                                                 value: value,
  //                                                 child: Row(
  //                                                   children: [
  //                                                     const SizedBox(
  //                                                       width: 15,
  //                                                     ),
  //                                                     Text(value!),
  //                                                   ],
  //                                                 ),
  //                                               );
  //                                             }).toList(),
  //
  //                                         isExpanded: true,
  //                                         isDense: true,
  //                                         onChanged: (String? newSelectedBank) {
  //                                           _onDropDownItemSelected(newSelectedBank);
  //                                         },
  //                                         value: _category,
  //
  //                                       ),
  //                                     ),
  //                                   );
  //                                 },
  //                               ),
  //                             ),
  //                             SizedBox(width: width*0.02),
  //                             Expanded(
  //                               child: FormField<String>(
  //                                 builder: (FormFieldState<String> state) {
  //                                   return InputDecorator(
  //                                     decoration: InputDecoration(
  //                                         contentPadding: EdgeInsets.only(left: width * 0.04, right: 0, top: 0, bottom: 0),
  //                                         errorStyle: const TextStyle(
  //                                             color: Colors.redAccent, fontSize: 16.0),
  //                                         border: OutlineInputBorder(
  //                                             borderRadius:
  //                                             BorderRadius.circular(10.0))),
  //                                     child: DropdownButtonHideUnderline(
  //                                       child: DropdownButton<String>(
  //                                         style: const TextStyle(
  //                                           fontSize: 16,
  //                                           color: Colors.grey,
  //                                         ),
  //                                         hint: const Text(
  //                                           "mm",
  //                                           style: TextStyle(
  //                                             color: Colors.grey,
  //                                             fontSize: 16,
  //                                           ),
  //                                         ),
  //                                         items: categoryList
  //                                             .map<DropdownMenuItem<String>>(
  //                                                 (String? value) {
  //                                               return DropdownMenuItem(
  //                                                 value: value,
  //                                                 child: Row(
  //                                                   children: [
  //                                                     const SizedBox(
  //                                                       width: 15,
  //                                                     ),
  //                                                     Text(value!),
  //                                                   ],
  //                                                 ),
  //                                               );
  //                                             }).toList(),
  //
  //                                         isExpanded: true,
  //                                         isDense: true,
  //                                         onChanged: (String? newSelectedBank) {
  //                                           _onDropDownItemSelected(newSelectedBank);
  //                                         },
  //                                         value: _category,
  //
  //                                       ),
  //                                     ),
  //                                   );
  //                                 },
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(width: width*0.02),
  //                   Expanded(
  //                     flex: 1,
  //                     child: Column(
  //                       children: [
  //                         Text('Card Code', style: Utils.masterCard),
  //                         TextFormField(
  //                           decoration: InputDecoration(
  //                               contentPadding: EdgeInsets.only(left: width * 0.04, right: 0, top: 0, bottom: 0),
  //                               hintText: "CVC",
  //                               errorStyle: const TextStyle(
  //                                   color: Colors.redAccent, fontSize: 16.0),
  //                               border: OutlineInputBorder(
  //                                   borderRadius:
  //                                   BorderRadius.circular(10.0))),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: height * 0.03,
  //               ),
  //               Text('Name on Card',
  //                   textAlign: TextAlign.start,
  //                   style: Utils.masterCard),
  //               TextFormField(
  //                 controller: cardOnName,
  //                 keyboardType: TextInputType.phone,
  //                 validator: (value) {
  //                   if (value!.isEmpty) {
  //                     return 'Please your name on card';
  //                   }
  //                   return null;
  //                 },
  //                 decoration: InputDecoration(
  //                   hintText: "Please your name on card",
  //                   // prefixIcon: const Icon(CupertinoIcons.creditcard),
  //                   contentPadding: EdgeInsets.only(left: width * 0.04, right: 0, top: 0, bottom: 0),
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                     borderSide: const BorderSide(
  //                       color: Color(0xffE9EBF0),
  //                       width: 0.5,
  //                     ),
  //                   ),
  //                   fillColor: const Color(0xffF3F3F3),
  //                   filled: true,
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: height * 0.02,
  //               ),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: CupertinoButton(
  //                       padding: EdgeInsets.zero,
  //                       color: Theme.of(context).primaryColor,
  //                       child: const Text("Save & Continue"),
  //                       onPressed: (){},
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }

}