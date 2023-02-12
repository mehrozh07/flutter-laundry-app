import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/pages/account-screen/account_page.dart';
import 'package:laundary_system/pages/cart-screen/cart_page.dart';
import 'package:laundary_system/pages/home-screen/home_page.dart';
import 'package:laundary_system/pages/order-screens/order_page.dart';

class MainScreen extends StatefulWidget {
  static const id = '/main-screen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final screens = [
     HomePage(),
    const CartPage(),
     OrderPage(),
     AccountPage(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context){
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textSize = MediaQuery.textScaleFactorOf(context);
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 1,
          indicatorColor: Colors.transparent,
          labelTextStyle: MaterialStateProperty.all(
              TextStyle(fontSize: textSize*14,
                  fontWeight: FontWeight.w500)
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: NavigationBar(
                height: height*0.07,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                selectedIndex: selectedIndex,
                animationDuration: const Duration(seconds: 2),
                onDestinationSelected: (index)=>{
                  setState((){
                    selectedIndex = index;
                  })
                },
                backgroundColor: Colors.white,
                destinations: [
                  NavigationDestination(
                    icon: const Icon(CupertinoIcons.house_fill),
                    label: 'Home',
                    selectedIcon: Icon(CupertinoIcons.house_fill,
                      color: Theme.of(context).primaryColor,),
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.shopping_cart),
                    selectedIcon: Icon(Icons.shopping_cart,
                      color: Theme.of(context).primaryColor,),
                    label: 'Cart',
                  ),
                  NavigationDestination(
                    icon: const Icon(CupertinoIcons.bag_fill),
                    selectedIcon: Icon(CupertinoIcons.bag_fill,
                      color: Theme.of(context).primaryColor,),
                    label: 'Orders',
                  ),
                  NavigationDestination(
                    icon: const Icon(CupertinoIcons.gear),
                    selectedIcon: Icon(Icons.settings,
                      color: Theme.of(context).primaryColor,),
                    label: 'Profile',
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}