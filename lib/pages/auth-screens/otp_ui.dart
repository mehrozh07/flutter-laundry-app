import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundary_system/auth-bloc/auth_cubit.dart';
import 'package:laundary_system/bottom-app-bar/bottom_bar.dart';
import 'package:laundary_system/pages/home-screen/fill_form.dart';
import 'package:laundary_system/pages/home-screen/home_page.dart';
import 'package:laundary_system/route_names.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import 'package:laundary_system/widgets/custom_field.dart';

class OtpUi extends StatelessWidget {
  final String? title;
  OtpUi({Key? key, this.title}) : super(key: key);
  final otpController1 = TextEditingController();
  final otpController2 = TextEditingController();
  final otpController3 = TextEditingController();
  final otpController4 = TextEditingController();
  final otpController5 = TextEditingController();
  final otpController6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('$title'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.15,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('OTP', style: Utils.headlineTextStyle),
                  Text(
                    'OTP has seen to your registed phone number.\n Please verify',
                    style: Utils.subtitle,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomField(
                      controller: otpController1,
                      first: true,
                      last: false,
                    ),
                  ),
                  Expanded(
                    child: CustomField(
                      controller: otpController2,
                      first: false,
                      last: false,
                    ),
                  ),
                  Expanded(
                    child: CustomField(
                      controller: otpController3,
                      first: false,
                      last: false,
                    ),
                  ),
                  Expanded(
                    child: CustomField(
                      controller: otpController4,
                      first: false,
                      last: false,
                    ),
                  ),
                  Expanded(
                    child: CustomField(
                      controller: otpController5,
                      first: false,
                      last: false,
                    ),
                  ),
                  Expanded(
                    child: CustomField(
                      controller: otpController6,
                      first: false,
                      last: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Did’t received OTP ? ',
                    style: Utils.simpleTitleStyle,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Send again',
                      style: Utils.coloredTextStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if(state is AuthLoggedInState){
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(context, CupertinoPageRoute(
                            builder: (context)=> const BottomBar()));
                      }else if(state is AuthFillFormState){
                        Navigator.pushReplacement(context, CupertinoPageRoute(
                            builder: (context)=> FillForm()));
                      }else if(state is ErrorState){
                          Utils.flushBarMessage(context, state.error, const Color(0xffED5050));
                        }
                    },
                    builder: (context, state) {
                      if(state is AuthLoadingState){
                        showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext dialogContext) {
                              return Center(child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Theme.of(dialogContext).primaryColor),
                              ));
                            });
                      }
                      return CupertinoButton(
                        color: Theme.of(context).primaryColor,
                        padding: EdgeInsets.zero,
                        child: Text(
                          'Verify',
                          style: Utils.buttonTextStyle,
                        ),
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context).verifyOTP(
                              otp:
                              otpController1.text+otpController2.text+otpController3.text+
                              otpController4.text+otpController5.text+otpController6.text,
                              context: context,
                          );
                          // if(BlocProvider.of<AuthCubit>(context).auth != null){
                          //
                          // }
                        },
                      );
                    },
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}