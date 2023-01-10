import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final bool? first, last;
  final TextEditingController? controller;
  const CustomField({Key? key, this.first, this.last, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextFormField(
          controller: controller,
          style: TextStyle(fontSize: MediaQuery.textScaleFactorOf(context)*30),
          textAlignVertical: TextAlignVertical.center,
          maxLength: 1,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.none,
          textCapitalization: TextCapitalization.none,
          readOnly: false,
          showCursor: false,
          autofocus: true,
          textAlign: TextAlign.center,
          onChanged: (value){
            if(value.length ==1 && last == false){
              FocusScope.of(context).nextFocus();
            }
            if(value.isEmpty && first == false){
              FocusScope.of(context).previousFocus();
            }
          },
          decoration: InputDecoration(
              counter: const Offstage(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            hintText: "0",
          ),
        ),
      ),
    );
  }
}
