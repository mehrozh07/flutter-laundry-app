import 'package:flutter/material.dart';
import 'package:laundary_system/utils/Utils_widget.dart';

class FillForm extends StatelessWidget {
   FillForm({Key? key}) : super(key: key);
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fill Form',
          style: Utils.appBarStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 8, right: 8),
        children: [
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Name required';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Name",
              contentPadding: EdgeInsets.only(left: width * 0.03, right: 0, top: 0, bottom: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              fillColor: const Color(0xffF3F3F3),
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}
