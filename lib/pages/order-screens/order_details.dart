import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/utils/Utils_widget.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: Utils.appBarStyle,
        ),
        centerTitle: true,
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      )),
                  child: Text(
                    'Schedule a laundry ',
                    style: Utils.orderListName,
                  ),
                  onPressed: () {}),
            )
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(
            left: 5,
            right: 5,
            bottom: MediaQuery.of(context).size.height * 0.1),
        children: [
          Image.network(
            'https://fiverr-res.cloudinary.com/i'
            'mages/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/187187199/original/dd08462'
            '6713593a5aebbccac02f1ffdaa02ebd8b/give-online-food-delivery-app-with-delivery-boy.jpg',
            height: 132,
            width: 132,
          ),
          Text(
            'Thanks for choosing Us!',
            textAlign: TextAlign.center,
            style: Utils.boldTextStyle,
          ),
          Text(
            'Your pickup has been confirmed',
            textAlign: TextAlign.center,
            style: Utils.subtitle,
          ),
          Card(
            color: const Color(0xffFFFFFF),
            borderOnForeground: true,
            shadowColor: const Color(0xffE9EBF0),
            elevation: 3,
            child: Column(
              children: [
                ListTile(
                  title: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Order #123',
                        style: Utils.blackBoldStyle,
                      ),
                      Text(
                        '(2 bags)',
                        style: Utils.textSubtitle,
                      ),
                    ],
                  ),
                  subtitle: const Text("11:35 AM, Thu, 15 Jun 2019"),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Divider(),
                ),
                // ListTile(
                //   title: Text('Wash & Fold',
                //     style: Utils.orderListName,),
                //   trailing: Icon(Icons.keyboard_arrow_up,
                //     color: Theme.of(context).primaryColor,
                //   ),
                // ),
                ExpansionTile(
                  title: Text(
                    'Wash & Fold',
                    style: Utils.orderListName,
                  ),
                  children: [
                    ListTile(
                      visualDensity: const VisualDensity(vertical: -4),
                      title: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            '2 x  Tshirt',
                            style: Utils.appBarStyle,
                          ),
                          Text(
                            '(Men)',
                            style: Utils.textSubtitle,
                          ),
                        ],
                      ),
                      trailing: Text(
                        '\$9',
                        style: Utils.coloredTextStyle,
                      ),
                    ),
                    ListTile(
                      visualDensity: const VisualDensity(vertical: -4),
                      title: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            '2 x  Tshirt',
                            style: Utils.appBarStyle,
                          ),
                          Text(
                            '(Men)',
                            style: Utils.textSubtitle,
                          ),
                        ],
                      ),
                      trailing: Text(
                        '\$9',
                        style: Utils.coloredTextStyle,
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    'Wash & Iron',
                    style: Utils.orderListName,
                  ),
                  children: [
                    ListTile(
                      visualDensity: const VisualDensity(vertical: -4),
                      title: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            '2 x  Tshirt',
                            style: Utils.appBarStyle,
                          ),
                          Text(
                            '(Men)',
                            style: Utils.textSubtitle,
                          ),
                        ],
                      ),
                      trailing: Text(
                        '\$9',
                        style: Utils.coloredTextStyle,
                      ),
                    ),
                    ListTile(
                      visualDensity: const VisualDensity(vertical: -4),
                      title: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            '2 x  Tshirt',
                            style: Utils.appBarStyle,
                          ),
                          Text(
                            '(Men)',
                            style: Utils.textSubtitle,
                          ),
                        ],
                      ),
                      trailing: Text(
                        '\$9',
                        style: Utils.coloredTextStyle,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Divider(),
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  title: Text('Subtotal', style: Utils.simpleText),
                  trailing: Text('\$220.23', style: Utils.itemCount),
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  title: Text('Tax', style: Utils.simpleText),
                  trailing: Text('\$10', style: Utils.itemCount),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Divider(),
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  title: Text('Total', style: Utils.orderListName),
                  trailing: Text('\$230.23', style: Utils.headlineTextStyle),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  visualDensity: const VisualDensity(horizontal: -4),
                  dense: true,
                  minLeadingWidth: 8,
                  leading: const Icon(CupertinoIcons.cube_box),
                  title: Text(
                    'Order Status',
                    style: Utils.orderListName,
                  ),
                  trailing: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            )),
                            builder: (context) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Order Status',
                                      style: Utils.orderListName,
                                    ),
                                    trailing: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(Icons.close)),
                                  ),
                                  const Divider(thickness: 2,),
                                  Container(
                                    color: Colors.white,
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.4,
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: null,
                                                  style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    visualDensity: const VisualDensity(horizontal: -4),
                                                    backgroundColor: const Color(0xffE9FFF2),
                                                    shape: const CircleBorder(),
                                                  ),
                                                    child: const Icon(CupertinoIcons.cube_box,
                                                      color: Color(0xff219653),),
                                                ),
                                             ),
                                            Expanded(
                                              child: CustomPaint(
                                                  size: const Size(
                                                      1, double.infinity),
                                                  painter:
                                                      DashedLineVerticalPainter()),
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: null,
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  visualDensity: const VisualDensity(horizontal: -4),
                                                  backgroundColor: const Color(0xffFFEFEF),
                                                  shape: const CircleBorder(),
                                                ),
                                                child: const Icon(Icons.location_history_outlined,
                                                  color: Color(0xffED5050),),
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomPaint(
                                                  size: const Size(
                                                      1, double.infinity),
                                                  painter:
                                                  DashedLineVerticalPainter()),
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: null,
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  visualDensity: const VisualDensity(horizontal: -4),
                                                  backgroundColor: const Color(0xffFFF1E2),
                                                  shape: const CircleBorder(),
                                                ),
                                                child: const Icon(Icons.access_time_sharp,
                                                  color: Color(0xffF39738),),
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomPaint(
                                                  size: const Size(
                                                      1, double.infinity),
                                                  painter:
                                                  DashedLineVerticalPainter()),
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: null,
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  visualDensity: const VisualDensity(horizontal: -4),
                                                  backgroundColor: const Color(0xffE1F4FF),
                                                  shape: const CircleBorder(),
                                                ),
                                                child: const Icon(Icons.wash_outlined,
                                                  color: Color(0xff2D9CDB),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Expanded(
                                                child: ListTile(
                                                  dense: true,
                                                  visualDensity: VisualDensity(vertical: -4),
                                                  title: Text('Confirmed'),
                                                  subtitle:
                                                  Text('Wed, 6 Jun 2019'),
                                                  trailing: Text('10:00 PM'),
                                                ),
                                              ),
                                              Divider(thickness: 2,),
                                              Expanded(
                                                child: ListTile(
                                                  dense: true,
                                                  visualDensity: VisualDensity(vertical: -2),
                                                  title: Text('Picked up'),
                                                  subtitle: Text('Wed, 6 Jun 2019'),
                                                  trailing: Text('10:00 PM'),
                                                ),
                                              ),
                                              Divider(thickness: 2,),
                                            Expanded(
                                              child: ListTile(
                                                visualDensity: VisualDensity(vertical: 0),
                                                dense: true,
                                                title: Text('In Progress'),
                                                subtitle: Text('Wed, 6 Jun 2019'),
                                                trailing: Text('10:00 PM'),
                                              ),
                                            ),
                                              Divider(thickness: 2,),
                                              Expanded(
                                                child: ListTile(
                                                  dense: true,
                                                  visualDensity: VisualDensity(vertical: 2),                                                  title: Text('Delivered'),
                                                  subtitle: Text('Wed, 6 Jun 2019'),
                                                  trailing: Text('10:00 PM'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: [
                                  //      Expanded(
                                  //         flex: 1,
                                  //         child:  Column(
                                  //           children: [
                                  //             const Expanded(child: Icon(CupertinoIcons.airplane)),
                                  //             CustomPaint(
                                  //                 size: const Size(1, double.infinity),
                                  //                 painter: DashedLineVerticalPainter()
                                  //             ),
                                  //             const Expanded(child: Icon(CupertinoIcons.airplane)),
                                  //           ],
                                  //         ),
                                  //      ),
                                  //     Expanded(
                                  //       flex: 4,
                                  //       child: Column(
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: const [
                                  //           ListTile(
                                  //             dense: true,
                                  //             contentPadding: EdgeInsets.zero,
                                  //             title: Text('Confirmed'),
                                  //             subtitle: Text('Wed, 6 Jun 2019'),
                                  //             trailing: Text('10:00 PM'),
                                  //           ),
                                  //           ListTile(
                                  //             dense: true,
                                  //             contentPadding: EdgeInsets.zero,
                                  //             title: Text('Confirmed'),
                                  //             subtitle: Text('Wed, 6 Jun 2019'),
                                  //             trailing: Text('10:00 PM'),
                                  //           ),
                                  //           ListTile(
                                  //             dense: true,
                                  //             contentPadding: EdgeInsets.zero,
                                  //             title: Text('Confirmed'),
                                  //             subtitle: Text('Wed, 6 Jun 2019'),
                                  //             trailing: Text('10:00 PM'),
                                  //           ),
                                  //           ListTile(
                                  //             dense: true,
                                  //             contentPadding: EdgeInsets.zero,
                                  //             title: Text('Confirmed'),
                                  //             subtitle: Text('Wed, 6 Jun 2019'),
                                  //             trailing: Text('10:00 PM'),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              );
                            });
                      },
                      child: Text(
                        'View detail',
                        style: Utils.coloredTextStyle,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
