import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/providers/service_provider.dart';
import 'package:laundary_system/widgets/add_to_cart_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../services/user_service.dart';
import '../../utils/Utils_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  UserService userService = UserService();
  User? user = FirebaseAuth.instance.currentUser;
  String? _category = '';

  final List<String> categoryList=["Men", "Woman", "Kid"];
  void _onDropDownItemSelected(String? newSelectedBank) {
    setState(() {
      _category = newSelectedBank;
    });
  }
  @override
  void initState() {
    _category = categoryList[0];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var serviceProvider = Provider.of<ServiceProvider>(context);
    serviceProvider.getService();
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('myCart').doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('products')
              .where('cartId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (!snapshot.hasData) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 48.0,
                                  height: 48.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: 40.0,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 6,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            if(snapshot.data!.docs.isEmpty){
              return const Center(child: Text("Your Cart is Empty"));
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return ListTile(
                  title: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text('${document['name']}',
                          style: Utils.orderListName),
                      Text(' (${document["serviceType"]})',
                          style: Utils.textSubtitle),
                    ],
                  ),
                  subtitle: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.start,
                    children: [
                      Text('Rs.${document['price']}',
                        style: Utils.headlineTextStyle,),
                      SizedBox(width: width*0.01),
                      SizedBox(
                        height: height*0.07,
                        width: width*0.26,
                        child: FormField<String>(
                          validator: (value){
                            if(value!.isEmpty){
                              return "*gender";
                            }
                            setState(() {
                              _category = value;
                            });
                            return null;
                          },
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  icon: const Icon(CupertinoIcons.chevron_down,
                                    color: Color(0xff38106A),
                                  ),
                                  style: Utils.simpleText,
                                  hint: Text(
                                    "gender?",
                                    style: Utils.simpleText,
                                  ),
                                  items: categoryList.map<DropdownMenuItem<String>>(
                                          (String? value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width*0.02,
                                              ),
                                              Text("$value"),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                  isExpanded: true,
                                  isDense: true,
                                  onChanged: (String? newSelectedBank) {
                                    _onDropDownItemSelected(newSelectedBank);
                                  },
                                  value: _category,

                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  trailing: AddToCartWidget(
                    productId: document['cartId'],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
