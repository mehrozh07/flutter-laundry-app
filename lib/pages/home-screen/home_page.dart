import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/generated/assets.dart';
import 'package:laundary_system/route_names.dart';
import 'package:laundary_system/utils/Utils_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:  NestedScrollView(
            headerSliverBuilder: (BuildContext context,bool? innerBoxIsScrolled){
          return [
          SliverAppBar(
            backgroundColor: Colors.white,
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
                  fillColor: Colors.blueGrey.shade50,
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
                      Navigator.pushNamed(context, RoutesNames.orderList);
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
              title: const Text(
                'Mehroz Hassan',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff38106A),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '#+923016061370',
                style: Utils.subtitle,
              ),
            ),
            expandedHeight: height*0.15,
          ),
          ];
        },
            body: Padding(
              padding: EdgeInsets.only(left: width*0.01, right: width*0.01),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    'Services',
                    style: Utils.boldTextStyle,
                  ),
                  SizedBox(
                    height: height*0.20,
                    width: width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      // shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) => SizedBox(
                        height: height*0.20,
                        width: width*0.46,
                        child: Card(
                          child: Image.asset(
                              height: height*0.10,
                              width: width*0.10,
                              Assets.assetsService1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height*0.35,
                    width: double.infinity,
                    child: const Card(
                      color: Color(0xff38106A),
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
                          border: Border.all(color: Colors.black26),
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
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
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