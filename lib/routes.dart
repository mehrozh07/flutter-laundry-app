import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/bottom-app-bar/bottom_bar.dart';
import 'package:laundary_system/pages/auth-screens/otp_ui.dart';
import 'package:laundary_system/pages/auth-screens/phone_login_ui.dart';
import 'package:laundary_system/pages/order-list/order_list.dart';
import 'package:laundary_system/pages/order-list/schedule_pickup.dart';
import 'package:laundary_system/route_names.dart';

class Routes{
  static Route? onGenerateRoutes(RouteSettings settings){
    switch(settings.name){
      case RoutesNames.phoneLogin:
        // Map arguments = (settings.arguments??{'title': "Home"}) as Map;
        return CupertinoPageRoute(builder: (_)=> PhoneLoginUi(
          // title: arguments['title'],
        ));
      case RoutesNames.otpScreen:
        Map arguments = (settings.arguments??{'title': "Verification Code"}) as Map;
        return CupertinoPageRoute(builder: (_)=> OtpUi(
          title: arguments['title'],
        ));
      case RoutesNames.orderList:
        return CupertinoPageRoute(builder: (_)=> const OrderList());
      case RoutesNames.mainScreen:
        return CupertinoPageRoute(builder: (_)=> const MainScreen());
      case RoutesNames.scheduledPickUp:
        return CupertinoPageRoute(builder: (_)=> const SchedulePickup());
      default:
        return CupertinoPageRoute(builder: (_)=> const Scaffold(
        body: Center(child: Text('Wrong Navigation')),
      ));
    }
  }
}