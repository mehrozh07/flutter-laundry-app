import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../utils/Utils_widget.dart';
import 'package:http/http.dart' as http;

class NotificationsService{
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  static void requestPermission(context) async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings setting = await messaging.requestPermission(
      sound: true,
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      provisional: false,
      criticalAlert: false,
    );
    if(setting.authorizationStatus == AuthorizationStatus.authorized){
      if (kDebugMode) {
        print("permission Granted.....................................");
      }
      // Utils.snackBar(message: "permission granted", context: context, color: Colors.green);
    }else{
      Utils.flushBarMessage("permission denied", context, Colors.red);
    }
  }
  static initInfo(context){
    var androidInitiaze = const AndroidInitializationSettings('assets/notification_icon.png');
    var iosInitialization =  const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitiaze,
      iOS: iosInitialization,
    );
    flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse: (payload) async{
          try{
            if(payload.payload != null && payload.payload!.isNotEmpty){

            }else{

            }
          }catch(e){
            if (kDebugMode) {
              print(e.toString());
            }
            Utils.flushBarMessage(e.toString(), context, Colors.red);
          }
        });
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
      if (kDebugMode) {
        print('.................onMessaging...................');
        print("onMessaging.....${remoteMessage.notification?.title}& ${remoteMessage.notification?.body}");
      }

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        remoteMessage.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: remoteMessage.notification?.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        "Laundry_Admin",
        "Laundry_Admin",
        importance: Importance.max,
        styleInformation: bigTextStyleInformation,
        priority: Priority.max,
        playSound: true,
      );
      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
      );
      await flutterLocalNotificationsPlugin.show(0,
        remoteMessage.notification?.title,
        remoteMessage.notification?.body,
        notificationDetails,
        payload: remoteMessage.data['body'],
      );
    });
  }
  static Future<void> sendPushNotification({title, body, token}) async{
    try{
      await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
            "key=AAAAPZOpei4:APA91bH89AR-7gytNK1uD_TYAuHuNskAxmTI9kLOaQESExLQb-ra_d23kbsTPT4owdeJrhloUa1FCFO956U4LQkpb5vmd7BTdpMy8GSbujDqSQ20gJt8vuzWvW4Lwkn-GI1_7Aq164IG",
          },
          body: jsonEncode(
            {
              'priority': 'high',
              'data': {
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'status': 'done',
                'body': body,
                'title': title,
              },
              "notification": {
                "title": title,
                "body": body,
                "android_channel_id": "Laundry_Admin",
              },
              "to": token,
            },
          )
      );
    }catch(e){
      if (kDebugMode) {
        print('........ERORRRRRRRRRRRRRRRR${e.toString()}');
      }
    }
  }


}