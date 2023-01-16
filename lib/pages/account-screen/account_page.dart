import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundary_system/auth-bloc/auth_cubit.dart';
import 'package:laundary_system/generated/assets.dart';
import 'package:laundary_system/pages/auth-screens/phone_login_ui.dart';
import 'package:laundary_system/providers/user_provider.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    userProvider.getUserData();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Utils.appBarStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 8, right: 8),
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey.shade300,
            child: const CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage(Assets.assetsProfile),
            ),
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              Text('${userProvider.documentSnapshot?['name']}',
                  textAlign: TextAlign.center, style: Utils.itemCount),
              const Icon(Icons.edit),
            ],
          ),
           Text('${userProvider.documentSnapshot?['status']}',
              textAlign: TextAlign.center,
               style: const TextStyle(
                color: Color(0xff82858A),
                fontSize: 16,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Card(
            color: const Color(0xffE9EBF0),
            child: Column(
              children: const [
                ListTile(
                  title: Text('Account Info'),
                  trailing: Icon(CupertinoIcons.person),
                ),
                Divider(),
                ListTile(
                  title: Text('My Address'),
                  trailing: Icon(CupertinoIcons.location),
                ),
                Divider(),
                ListTile(
                  title: Text('Change Password'),
                  trailing: Icon(CupertinoIcons.lock_shield),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text('Others', textAlign: TextAlign.start, style: Utils.itemCount),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Card(
            color: const Color(0xffE9EBF0),
            child: Column(
              children: const [
                ListTile(
                  title: Text('Reports & Feedback'),
                  trailing: Icon(CupertinoIcons.text_bubble),
                ),
                Divider(),
                ListTile(
                  title: Text('Refer & Earn'),
                  trailing: Icon(Icons.share),
                ),
                Divider(),
                ListTile(
                  title: Text('App Notification'),
                  trailing: Icon(CupertinoIcons.bell),
                ),
                Divider(),
                ListTile(
                  title: Text('Settings'),
                  trailing: Icon(CupertinoIcons.settings_solid),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLogOutState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => PhoneLoginUi()));
              }
            },
            builder: (context, state) {
              return TextButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).logout();
                  },
                  child: const Text('Logout'));
            },
          )
        ],
      ),
    );
  }
}