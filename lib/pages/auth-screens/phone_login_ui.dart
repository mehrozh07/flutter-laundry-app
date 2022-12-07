import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laundary_system/route_names.dart';
import 'package:laundary_system/utils/Utils_widget.dart';

class PhoneLoginUi extends StatelessWidget {
  const PhoneLoginUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
            horizontal: width*0.05,
            vertical: height*0.5,
        ),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: "Phone number",
              contentPadding: EdgeInsets.only(left: width*0.03),
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              fillColor: const Color(0xffF3F3F3),
              filled: true,
            ),
          ),
          SizedBox(height: height*0.05,),
          CupertinoButton(
            color: Theme.of(context).primaryColor,
              child: const Text('Login'),
              onPressed: (){
              Navigator.pushNamed(context, RoutesNames.otpScreen);
              Utils.flushBarMessage(context, 'Logging In..', const Color(0xff219653));
              },
          ),
          SizedBox(height: height*0.01,),
          Row(
            children: const [
              Expanded(child: Divider(
                thickness: 1,
              )),
            ],
          ),
          Text('You can also login with',
            textAlign: TextAlign.center,
            style: Utils.subtitle,),
          SizedBox(height: height*0.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 36,
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: BorderSide(color: Theme.of(context).primaryColor)
                  ),
                ),
                  onPressed: (){},
                  icon: Icon(Icons.facebook,color: Theme.of(context).primaryColor),
              ),
              SizedBox(width: width*0.03,),
              IconButton(
                  iconSize: 36,
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: Theme.of(context).primaryColor)
                    ),
                  ),
                  onPressed: (){},
                  icon: Icon(FontAwesomeIcons.google,
                      color: Theme.of(context).primaryColor)),
            ],
          ),
        ],
      ),
    );
  }
}
