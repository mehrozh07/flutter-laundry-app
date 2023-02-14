import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/Utils_widget.dart';

class OrderService{

   Text? getOrderConfirmDate(snapshot){
     if(snapshot['orderConfirmTime'] == null){
       return const Text("Not Updated yet!");
     }else{
       return Text(DateFormat("MMM d, yyyy").format(snapshot?['orderConfirmTime'].toDate()));
     }
   }
   Text? getOrderConfirmTime(snapshot){
     if(snapshot['orderConfirmTime'] == null){
       return const Text("waiting!");
     }else{
       return Text(DateFormat("hh:mm a").format(snapshot?['orderConfirmTime'].toDate()));
     }
   }
   Text? getOrderpickupDate(snapshot){
     if(snapshot['orderPickupTime'] == null){
       return const Text("Not Updated yet!");
     }else{
       return Text(DateFormat("MMM d, yyyy").format(snapshot?['orderPickupTime'].toDate()));
     }
   }
   Text? getOrderpickupTime(snapshot){
     if(snapshot['orderPickupTime'] == null){
       return const Text("waiting!");
     }else{
       return Text(DateFormat("hh:mm a").format(snapshot?['orderPickupTime'].toDate()));
     }
   }
   Text? getOrderProgressDate(snapshot){
     if(snapshot['orderProgressTime'] == null){
       return const Text("Not Updated yet!");
     }else{
       return Text(DateFormat("MMM d, yyyy").format(snapshot?['orderProgressTime'].toDate()));
     }
   }
   Text? getOrderProgressTime(snapshot){
     if(snapshot['orderProgressTime'] == null){
       return const Text("waiting!");
     }else{
       return Text(DateFormat("hh:mm a").format(snapshot?['orderProgressTime'].toDate()));
     }
   }
   Text? getOrderDeliveredDate(snapshot){
     if(snapshot['orderDeliveredTime'] == null){
       return const Text("Not Updated yet!");
     }else{
       return Text(DateFormat("MMM d, yyyy").format(snapshot?['orderDeliveredTime'].toDate()));
     }
   }
   Text? getOrderDeliveredTime(snapshot){
     if(snapshot['orderDeliveredTime'] == null){
       return const Text("waiting!");
     }else{
       return Text(DateFormat("hh:mm a").format(snapshot?['orderDeliveredTime'].toDate()));
     }
   }

   Text? getOrderPickupDateTime(snapshot){
     if(snapshot['pickupTime'] == null){
       return const Text("wait!");
     }else{
       return Text("${DateFormat("MMM d, yyyy").format(snapshot?['pickupTime'].toDate())} to "
           "${DateFormat("MMM d, yyyy").format(snapshot?['deliveryTime'].toDate())}");
     }
   }
   Widget getorderPickUpTime(snapshot){
     if(snapshot['pickupTime'] == null){
       return const Text("waiting!");
     }else{
       return Text(DateFormat("hh:mm").format(snapshot?['pickupTime'].toDate()), style: Utils.boldHome);
     }
   }
   Widget getOrderDeliveryTime(snapshot){
     if(snapshot['deliveryTime'] == null){
       return const Text("waiting!");
     }else{
       return Text(DateFormat("hh:mm").format(snapshot?['deliveryTime'].toDate()), style: Utils.boldHome);
     }
   }

   Widget getorderPickUpDate(snapshot){
     if(snapshot['pickupTime'] == null){
       return const Text("waiting!");
     }else{
       return Text(DateFormat("MMM d, yyyy").format(snapshot?['pickupTime'].toDate()), style: Utils.textSubtitle);
     }
   }
   Widget getOrderDeliveryDate(snapshot){
     if(snapshot['deliveryTime'] == null){
       return const Text("waiting!");
     }else{
       return Text(DateFormat("MMM d, yyyy").format(snapshot?['deliveryTime'].toDate()),style: Utils.textSubtitle);
     }
   }
}