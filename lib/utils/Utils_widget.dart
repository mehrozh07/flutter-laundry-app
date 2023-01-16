import 'package:flutter/material.dart';

class Utils{
static flushBarMessage(context, text, bgColor,){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$text',
      style: const TextStyle(
        color: Color(0xFFFFEFFF),
      ),),
      backgroundColor: bgColor,
     duration: const Duration(seconds: 4),
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(5),
     ),
    behavior: SnackBarBehavior.floating,
   ),
  );
}

static TextStyle headlineTextStyle = const TextStyle(
  fontSize: 18,
  color: Color(0xffCE1567),
  fontWeight: FontWeight.bold,
);
static TextStyle boldTextStyle = const TextStyle(
  fontSize: 26,
  color: Color(0xff38106A),
  fontWeight: FontWeight.bold,
);
static TextStyle itemCount = const TextStyle(
  fontSize: 19,
  color: Color(0xff38106A),
  fontWeight: FontWeight.bold,
);
static TextStyle simpleText = const TextStyle(
  fontSize: 16,
  color: Color(0xff38106A),
  fontWeight: FontWeight.normal,
);
static TextStyle orderListName = const TextStyle(
  fontSize: 19,
  color: Color(0xff38106A),
  fontWeight: FontWeight.bold,
);
static TextStyle blackBoldStyle = const TextStyle(
  fontSize: 26,
  color: Color(0xff292929),
  fontWeight: FontWeight.bold,
);
static TextStyle blackSimple = const TextStyle(
  fontSize: 26,
  color: Color(0xff292929),
  fontWeight: FontWeight.normal,
);
static TextStyle appBarStyle = const TextStyle(
  fontSize: 21,
  color: Color(0xff292929),
  fontWeight: FontWeight.normal,
);
static TextStyle subtitle = const TextStyle(
  fontSize: 15,
  color: Color(0xff82858A),
  fontWeight: FontWeight.normal,
);
static TextStyle textSubtitle = const TextStyle(
  fontSize: 15,
  color: Color(0xff595757),
  fontWeight: FontWeight.normal,
);
static TextStyle coloredTextStyle = const TextStyle(
  fontSize: 15,
  color: Color(0xffCE1567),
  fontWeight: FontWeight.normal,
);
static TextStyle simpleTitleStyle = const TextStyle(
  fontSize: 15,
  color: Color(0xff292929),
  fontWeight: FontWeight.normal,
);
static TextStyle buttonTextStyle = const TextStyle(
  fontSize: 16,
  color: Color(0xffFFFFFF),
  fontWeight: FontWeight.normal,
);
}