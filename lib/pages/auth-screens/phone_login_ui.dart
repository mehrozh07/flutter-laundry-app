import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundary_system/auth-bloc/auth_cubit.dart';
import 'package:laundary_system/route_names.dart';
import 'package:laundary_system/utils/Utils_widget.dart';

class PhoneLoginUi extends StatelessWidget {
  PhoneLoginUi({Key? key}) : super(key: key);
  final phoneController = TextEditingController();

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
          horizontal: width * 0.05,
          vertical: height * 0.2,
        ),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.wash_outlined,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: width * 0.01,
              ),
              Text(
                'Momy Laundry',
                style: GoogleFonts.aladin(
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
          SizedBox(
            height: height * 0.1,
          ),
           CupertinoTextField(
             controller: phoneController,
             clearButtonMode: OverlayVisibilityMode.editing,
            keyboardType: TextInputType.phone,
            placeholder: "phone number",
             maxLengthEnforcement: MaxLengthEnforcement.enforced,
             onChanged: (v) {
               if (v.isEmpty) {
                 Utils.flushBarMessage(context, "enter phone number", Colors.pinkAccent);
               }
              return;
             },
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0,
                  color: Theme.of(context).primaryColor,
                ),
              borderRadius: BorderRadius.circular(4.0),
            ),

          ),
          // TextFormField(
          //   controller: phoneController,
          //   keyboardType: TextInputType.phone,
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       return 'Your phone Number';
          //     }
          //     return null;
          //   },
          //   decoration: InputDecoration(
          //     hintText: "Phone number",
          //     contentPadding: EdgeInsets.only(left: width * 0.03, right: 0, top: 0, bottom: 0),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //       borderSide: BorderSide.none,
          //     ),
          //     fillColor: const Color(0xffF3F3F3),
          //     filled: true,
          //   ),
          // ),
          // SizedBox(
          //   height: height * 0.01,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Text(
          //       'Forgot Password?',
          //       style: Utils.coloredTextStyle,
          //     ),
          //   ],
          // ),
          SizedBox(
            height: height * 0.05,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthCodeSendState) {
                Navigator.pushNamed(context, RoutesNames.otpScreen);
                Utils.flushBarMessage(
                    context, 'Logging In..', const Color(0xff219653));
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext dialogContext) {
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor),
                    ));
                  },
                );
              }
              return CupertinoButton(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
                child: const Text('Login'),
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context)
                      .sendOtp(phoneController.text, context);
                },
              );
            },
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            children: const [
              Expanded(
                  child: Divider(
                thickness: 1,
              )),
            ],
          ),
          Text(
            'You can also login with',
            textAlign: TextAlign.center,
            style: Utils.subtitle,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 36,
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                ),
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.facebook,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                width: width * 0.03,
              ),
              IconButton(
                  iconSize: 36,
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side:
                            BorderSide(color: Theme.of(context).primaryColor)),
                  ),
                  onPressed: () {},
                  icon: Icon(FontAwesomeIcons.google,
                      color: Theme.of(context).primaryColor)),
            ],
          ),
        ],
      ),
    );
  }
}