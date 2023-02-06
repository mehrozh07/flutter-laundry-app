import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundary_system/Repositry/Data-Repositry/firebase_api.dart';
import 'package:laundary_system/auth-bloc/auth_cubit.dart';
import 'package:laundary_system/pages/auth-screens/phone_login_ui.dart';
import 'package:laundary_system/providers/user_provider.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
    AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  FirebaseApi firebaseApi = FirebaseApi();
  var name = TextEditingController();
  var address = TextEditingController();
  var emailC = TextEditingController();
  var mobile = TextEditingController();
  var pinCode = TextEditingController();
  var status = TextEditingController();

   bool editing = true;
   File? _image;

    @override
  void initState() {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      if(userProvider.documentSnapshot!.exists){
        name.text =  userProvider.documentSnapshot?['name'] ?? "Name" ;
        address.text = userProvider.documentSnapshot?['status'] ?? "status";
        mobile.text = userProvider.documentSnapshot?['phoneNumber'];
        pinCode.text = userProvider.documentSnapshot?['deliveryAddress']?? "Update Address";
      }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    userProvider.getUserData();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Info',
          style: Utils.appBarStyle,
        ),
        centerTitle: true,
        leading: TextButton(
            onPressed: (){
              setState(() {
                editing = !editing;
              });
            },
            child: editing == false ?
            Icon(CupertinoIcons.multiply, size: 30, color: Theme.of(context).primaryColor) :
            Icon(CupertinoIcons.pen, size: 30, color: Theme.of(context).primaryColor)),
        actions: [
              Visibility(
                visible: editing ? false : true,
                child: TextButton(
                    onPressed: (){
                      firebaseApi.user.doc(firebaseApi.uid?.uid).update({
                        "name": name.text,
                        "status": address.text,
                      });
                      setState(() {
                        editing = !editing;
                      });
                    },
                    child: editing == false ?
                    Icon(CupertinoIcons.checkmark, size: 30, color: Theme.of(context).primaryColor) :
                 const Icon(null),
                ),
              ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 8, right: 8),
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey.shade300,
            child: InkWell(
              onTap: (){
                if(userProvider.documentSnapshot?['profile']==null){
                  showDialog(context: context, builder: (context){
                    return Dialog(
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: _image == null ?
                                  const NetworkImage('https://www.pngkit.com/png/full/335-3351353'
                                      '_the-application-process-create-account-icon-png.png') as ImageProvider
                                   : FileImage(_image!),
                            ),
                            Positioned(
                              right: 90,
                              top: 65,
                              child: GestureDetector(
                                onTap: () {
                                  userProvider.pickImageGallery(context).then((value) {
                                    _image = value;
                                    userProvider.isPickAvail = true;
                                  });
                                },
                                child: const Icon(Icons.add_a_photo_outlined,
                                  size: 40,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 160,
                              child: IconButton(
                                  onPressed: (){
                                    if(userProvider.isPickAvail == true){
                                      userProvider.uploadProfileImage(userProvider.image!.path,
                                          DateTime.fromMillisecondsSinceEpoch(100).toString()).then((value){
                                        FirebaseFirestore.instance.collection('users')
                                            .doc(FirebaseAuth.instance.currentUser?.uid).update({
                                          "profile": value,
                                        }).then((value){
                                          Navigator.pop(context);
                                        });
                                      });
                                    }else{
                                      Utils.flushBarMessage(context , 'please pick Image', Colors.redAccent);
                                    }
                                  },
                                  icon: const Icon(CupertinoIcons.checkmark
                              )),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                }
              },
              child: CircleAvatar(
                radius: 55,
                backgroundImage: userProvider.documentSnapshot?['profile'] == null ?
                const NetworkImage('https://www.pngkit.com/png/full/335-3351353_the-application-process-create-account-icon-png.png')  as ImageProvider :
                NetworkImage(userProvider.documentSnapshot?['profile']),
              ),
            ),
          ),
          Text('${userProvider.documentSnapshot?['name']}',
              textAlign: TextAlign.center, style: Utils.itemCount),
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AbsorbPointer(
                  absorbing: editing,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(CupertinoIcons.person),
                        ),
                      ),
                      const Divider(),
                      TextFormField(
                        controller: mobile,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(CupertinoIcons.phone_circle),
                        ),
                      ),
                      const Divider(),
                      TextFormField(
                        controller: address,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(CupertinoIcons.staroflife),
                        ),
                      ),
                      const Divider(),
                      TextFormField(
                        controller: pinCode,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(CupertinoIcons.location),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
                  child: Text('Logout', style: TextStyle(color: Theme.of(context).primaryColor)
                  ));
            },
          )
        ],
      ),
    );
  }
}