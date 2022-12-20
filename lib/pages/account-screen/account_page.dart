import 'package:flutter/material.dart';
import 'package:laundary_system/generated/assets.dart';
import 'package:laundary_system/utils/Utils_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: Utils.appBarStyle,),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey.shade300,
            child: const CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage(Assets.assetsProfile),
            ),
          ),
           Text('Mehrooz Hassan',
              textAlign: TextAlign.center,
              style: Utils.itemCount),
        ],
      ),
    );
  }
}
