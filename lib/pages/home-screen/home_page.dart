import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/generated/assets.dart';
import 'package:laundary_system/models/catogory_model.dart';
import 'package:laundary_system/pages/order-screens/order_list.dart';
import 'package:laundary_system/providers/categories_provider.dart';
import 'package:laundary_system/providers/user_provider.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var catProvider = Provider.of<CategoriesProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    catProvider.category();
    userProvider.getUserData();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE5E5E5),
        body:  NestedScrollView(
            headerSliverBuilder: (BuildContext context,bool? innerBoxIsScrolled){
          return [
          SliverAppBar(
            backgroundColor: const Color(0xffE5E5E5),
            automaticallyImplyLeading: false,
            pinned: false,
            snap: false,
            floating: true,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                  left: 15, right: 15, top: 0, bottom: 0),
              expandedTitleScale: 1,
              title: TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      left: 15, right: 0, top: 0, bottom: 0),
                  fillColor: const Color(0xffF3F3F3),
                  filled: true,
                  prefixIcon: const Icon(CupertinoIcons.search),
                  hintText: "Search services",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            title: ListTile(
              contentPadding: EdgeInsets.zero,
              trailing: Badge(
                badgeColor: const Color(0xffF39738),
                position: BadgePosition.topEnd(top: 10, end: 10),
                badgeContent: null,
                child: IconButton(
                    visualDensity: const VisualDensity(horizontal: -4),
                    padding: EdgeInsets.zero,
                    onPressed: () {

                    },
                    icon: Icon(
                      CupertinoIcons.bell,
                      color: Theme.of(context).primaryColor,
                    )),
              ),
              dense: true,
              visualDensity: const VisualDensity(horizontal: -4),
              leading: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(Assets.assetsProfile),
              ),
              title: Text(
                '${userProvider.documentSnapshot?['name']}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff38106A),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('${userProvider.documentSnapshot?['phoneNumber']}',
                style: Utils.subtitle,
              ),
            ),
            expandedHeight: height*0.15,
          ),
          ];
        },
            body: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: width*0.01, right: width*0.01,),
              children: [
                Text(
                  'Services',
                  style: Utils.boldTextStyle,
                ),
                SizedBox(
                  height: 84,
                  width: width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: catProvider.categoriesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      CategoryModel model = catProvider.categoriesList[index];
                      // print(model.services?.length);
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (context) => OrderList(
                                  categoryName: model.serviceName,
                            )));
                            if (kDebugMode) {
                              print(model.serviceName);
                            }
                          },
                          child: Container(
                            height: 84,
                            width: 85,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 4.0,
                                  color: Colors.black12,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network('${model.serviceImage}',
                                  height: 38,
                                  width: 38,
                                  color: const Color(0xff38106A),
                                ),
                                Text('${model.serviceName}',
                                  style: Utils.simpleText,),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ),
                SizedBox(height: height*0.03,),
                SizedBox(
                  height: height*0.30,
                  width: double.infinity,
                  child: Card(
                    color: const Color(0xff38106A),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(Assets.assetsService3),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: const [
                                Text('40% ',
                                  style: TextStyle(
                                    fontSize: 29,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                ),),
                                Text('OFF',
                                  style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ],
                            ),
                            const Text('First Order',
                              style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),),
                            TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  side: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: (){},
                                child: const Text('Book Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  'Last Orders',
                  style: Utils.boldTextStyle,
                ),
                ListView.builder(
                  shrinkWrap: true,
                    itemCount: 5,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, snapshot){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: height*0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffF9F9F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.time, size: 31, color: Color(0xffF39738),),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  title: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Text("Order #123", style: Utils.blackBoldStyle,),
                                      Text("(2 bags)", style: Utils.simpleTitleStyle,),
                                    ],
                                  ),
                                  trailing: Text("\$80", style: Utils.headlineTextStyle,),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('10:00', style: Utils.boldTextStyle,),
                                        Text('Thu, 1 Apr',style: Utils.textSubtitle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 80,
                                      child: CustomPaint(
                                          size: const Size(1, double.infinity),
                                          painter: DashedLineVerticalPainter()
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('10:00', style: Utils.boldTextStyle,),
                                        Text('Thu, 1 Apr',style: Utils.textSubtitle),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
        ),
      ),
    );
  }
}
class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = const Color(0xffC3C8D2)
      ..strokeWidth = 2;
    while (startY < size.height) {
      canvas.drawLine(Offset(startY , 0), Offset( startY+dashHeight, 0,), paint);
      startY += dashHeight + dashSpace;
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}