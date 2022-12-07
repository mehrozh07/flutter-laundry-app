import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import 'package:laundary_system/widgets/custom_field.dart';

class OtpUi extends StatelessWidget {
  final String? title;
  const OtpUi({Key? key, this.title}) : super(key: key);

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
          horizontal: width*0.05,
          vertical: height*0.15,),
        child: SingleChildScrollView(
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('OTP',
                      style: Utils.headlineTextStyle),
                  Text('OTP has seen to your registed phone number.\n Please verify',
                    style: Utils.subtitle,),
                ],
              ),
              SizedBox(height: height*0.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: CustomField(first: true, last: false,),
                  ),
                  Expanded(
                    child: CustomField(first: false, last: false,),
                  ),
                  Expanded(
                    child: CustomField(first: false, last: false,),
                  ),
                  Expanded(
                    child: CustomField(first: false, last: false,),
                  ),
                  Expanded(
                    child: CustomField(first: false, last: false,),
                  ), Expanded(
                    child: CustomField(first: false, last: true,),
                  ),


                ],
              ),
              SizedBox(height: height*0.01,),
              Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                Text('Did’t received OTP ? ',
                style: Utils.simpleTitleStyle,),
                InkWell(
                  onTap: (){},
                    child: Text('Send again',style: Utils.coloredTextStyle,),
                ),
                ],
              ),
              SizedBox(height: height*0.06,),
              Row(
                children: [
                  Expanded(
                      child: CupertinoButton(
                        color: Theme.of(context).primaryColor,
                          child: Text('Verify',
                            style: Utils.buttonTextStyle,),
                          onPressed: (){

                          },)),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
