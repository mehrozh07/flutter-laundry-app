import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/pages/auth-screens/otp_ui.dart';
import 'package:laundary_system/pages/auth-screens/phone_login_ui.dart';
import 'package:laundary_system/route_names.dart';

class Routes{
  static Route? onGenerateRoutes(RouteSettings settings){
    switch(settings.name){
      case RoutesNames.phoneLogin:
        // Map arguments = (settings.arguments??{'title': "Home"}) as Map;
        return CupertinoPageRoute(builder: (_)=> const PhoneLoginUi(
          // title: arguments['title'],
        ));
      case RoutesNames.otpScreen:
        Map arguments = (settings.arguments??{'title': "Verification Code"}) as Map;
        return CupertinoPageRoute(builder: (_)=> OtpUi(
          title: arguments['title'],
        ));
      default:
        return CupertinoPageRoute(builder: (_)=> const Scaffold(
        body: Center(child: Text('Wrong Navigation')),
      ));
    }
  }
}