import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/generated/assets.dart';
import 'package:laundary_system/route_names.dart';
import 'package:laundary_system/utils/Utils_widget.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Order List', style: Utils.appBarStyle,),
      ),
      bottomSheet: Container(
        height: height*0.19,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: -4),
                leading: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(horizontal: -4),
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.15),
                    shape: const CircleBorder(),
                  ),
                  child: Icon(
                    CupertinoIcons.cube,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                ),
                title: Text('Total', style: Utils.subtitle,),
                subtitle: const Text('16 Items',
                  style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff292929),
                  fontWeight: FontWeight.bold,
                 ),
                ),
                trailing: Column(
                  children: [
                    Text('Cost', style: Utils.subtitle,),
                    Text('18\$', style: Utils.headlineTextStyle,),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      color: Theme.of(context).primaryColor,
                        child: const Text('Confirm Order'),
                        onPressed: (){
                        Navigator.pushNamed(context, RoutesNames.scheduledPickUp);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 20,
                      (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 10),
                    child: Container(
                      height: height*0.1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffF9F9F9)
                      ),
                      child:
                      ListTile(
                        leading: Image.asset(Assets.assetsService, height: 38,width: 38,),
                        title: Text('T-Shirt', style: Utils.orderListName,),
                        subtitle: Wrap(
                                  children: [
                                    Text('\$5', style: Utils.headlineTextStyle,),
                                    SizedBox(width: width*0.05,),
                                    Text('Men', style: Utils.simpleText,),
                                  ],
                                ),
                        trailing: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: IconButton(
                                style: IconButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  side: const BorderSide(
                                    color: Color(0xffC3C8D2),
                                  ),
                                ),
                                onPressed: (){},
                                icon: const Icon(CupertinoIcons.minus),
                              ),
                            ),
                            SizedBox(width: width*0.01,),
                            Text('0',style: Utils.itemCount,),
                            SizedBox(width: width*0.01,),
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: IconButton(
                                  style: IconButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    side: const BorderSide(
                                      color: Color(0xffC3C8D2),
                                    ),
                                  ),
                                  onPressed: (){},
                                  icon: const Icon(CupertinoIcons.add)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          }),
          ),
        ],
      ),
    );
  }
}
