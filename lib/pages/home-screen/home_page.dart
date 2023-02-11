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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';

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
                  left: 8, right: 8, top: 0, bottom: 0),
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
                backgroundColor: const Color(0xffF39738),
                // alignment: const AlignmentDirectional(100, 50),
                padding: const EdgeInsets.only(top: 10, left: 10),
                // position: BadgePosition.topEnd(top: 10, end: 10),
                // badgeContent: null,
                child: IconButton(
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    padding: EdgeInsets.only(left: width*0.05, top: 0, right: 0, bottom: 0),
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.bell,
                      color: Theme.of(context).primaryColor,
                    ),
                ),
              ),
              dense: true,
              visualDensity: const VisualDensity(horizontal: -4),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                backgroundImage: userProvider.documentSnapshot?['profile'] != null?
                NetworkImage(userProvider.documentSnapshot?['profile']) :
                const AssetImage(Assets.assetsAppIcon) as ImageProvider,
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
              padding: EdgeInsets.only(left: width*0.02, right: width*0.02),
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
                        padding: const EdgeInsets.only(left: 0, right: 8),
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
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('orders')
                      .where('orderStatus', isNotEqualTo: "Delivered").limit(5)
                      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
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
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              enabled: true,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
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
                          ],
                        ),
                      );
                    }
                    return ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.only(left: 6,right: 6, top: 8, bottom: 8),
                          child: Container(
                            height: height*0.2,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xffF9F9F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(CupertinoIcons.time, size: 41, color: Color(0xffF39738),),
                                SizedBox(width: width*0.03,),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            Text("Order #${document['orderId']}", style: Utils.blackHome),
                                            Text("(${document['laundries'].length} bags)", style: Utils.simpleTitleStyle,),
                                          ],
                                        ),
                                        trailing: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("\$80", style: Utils.headlineTextStyle,),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('10:00', style: Utils.boldHome),
                                              Text('Thu, 1 Apr',style: Utils.textSubtitle),
                                            ],
                                          ),
                                          Container(
                                            width: width*0.2,
                                            height: 30,
                                            color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.circle_outlined, size: 14, color: Theme.of(context).primaryColor,),
                                                CustomPaint(
                                                    painter: DrawDottedhorizontalline()
                                                ),
                                                Icon(Icons.circle,size: 14, color: Theme.of(context).primaryColor),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('10:00', style: Utils.boldHome),
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
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
        ),
      ),
    );
  }
}
class DrawDottedhorizontalline extends CustomPainter {
  Paint? _paint;
  DrawDottedhorizontalline() {
    _paint = Paint();
    _paint!.color = Colors.black; //dots color
    _paint!.strokeWidth = 2; //dots thickness
    _paint!.strokeCap = StrokeCap.square; //dots corner edges
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -24; i < 24; i = i + 3) {
      // 15 is space between dots
      if (i % 2 == 0) {
        canvas.drawLine(Offset(i, 0.0), Offset(i + 0.5, 0.0), _paint!);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}