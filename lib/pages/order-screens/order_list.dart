import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/providers/service_provider.dart';
import 'package:laundary_system/models/service_model.dart';
import 'package:laundary_system/providers/cart_provider.dart';
import 'package:laundary_system/route_names.dart';
import 'package:laundary_system/services/cart_service.dart';
import 'package:laundary_system/services/user_service.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import 'package:provider/provider.dart';
import '../../widgets/add_to_cart_widget.dart';

class OrderList extends StatefulWidget {
  final String? categoryName;
  const OrderList({Key? key, this.categoryName}) : super(key: key);


  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> with SingleTickerProviderStateMixin{
  TabController? _tabController;

  List<String> options = [
    'Wash', 'Ironing', 'Fold',
    'Dry', 'Clean', 'Wash&Dry',
    'Wash&Ironing', "Ironing&Clean",
  ];
  String? _category = '';

  final List<String> categoryList=["Men", "Woman", "Kid"];
  void _onDropDownItemSelected(String? newSelectedBank) {
    setState(() {
      _category = newSelectedBank;
    });
  }
  UserService userService = UserService();
  CartService cartService = CartService();

  @override
  void initState() {
    _category = categoryList[0];
    _tabController = TabController(length: 8, vsync: this);
    super.initState();
  }
  int i = 0;
  int tag = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var text = MediaQuery.textScaleFactorOf(context);
    var serviceProvider = Provider.of<ServiceProvider>(context);
    var cartProvider = Provider.of<CartProvider>(context);
    serviceProvider.getService();
    serviceProvider.getProductByCategory(widget.categoryName!);
    cartProvider.getSubTotal();
    cartProvider.confirmOrder();
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Order List', style: Utils.appBarStyle),
      ),
      bottomSheet: Container(
        height: height*0.19,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8,
              spreadRadius: 0.6,
              offset: Offset(0.1, 0.1),
            )
          ],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
            topRight: Radius.circular(10),)
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
                title: Text('Total', style: Utils.subtitle),
                subtitle: Text('${cartProvider.totalQuantity}',
                  style: TextStyle(
                  fontSize: text*18,
                  color: const Color(0xff292929),
                  fontWeight: FontWeight.bold,
                 ),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Cost', style: Utils.subtitle),
                    Text('Rs.${cartProvider.total}',
                        style: Utils.headlineTextStyle),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: AbsorbPointer(
                      absorbing: cartProvider.totalQuantity == 0.0 ? true : false,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        color: cartProvider.totalQuantity == 0.0 ?
                        Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).primaryColor,
                          child: const Text('Confirm Order'),
                          onPressed: (){
                          Navigator.pushNamed(context, RoutesNames.scheduledPickUp);
                          }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          //  SliverAppBar(
          //    automaticallyImplyLeading: false,
          //  flexibleSpace: Container(
          //    height: height*0.06,
          //    decoration: const BoxDecoration(
          //      color: Colors.white,
          //    ),
          //    child: TabBar(
          //      controller: _tabController,
          //      onTap: (value){
          //        if(value == 0){
          //          setState(() {
          //
          //          });
          //        }
          //        setState(() {
          //          tag = value;
          //
          //        });
          //      },
          //      dragStartBehavior: DragStartBehavior.start,
          //      padding: EdgeInsets.zero,
          //      automaticIndicatorColorAdjustment: true,
          //      physics: const BouncingScrollPhysics(),
          //      indicatorWeight: 0.1,
          //      isScrollable: true,
          //      labelColor: Colors.black,
          //      indicatorColor: const Color(0xff38106A),
          //      unselectedLabelColor: const Color(0xff38106A),
          //      indicatorSize: TabBarIndicatorSize.label,
          //        tabs: List.generate(
          //            options.length,
          //                (index) {
          //              return Container(
          //                  padding: const EdgeInsets.only(left: 4, right: 4,top: 2,bottom: 2),
          //                  decoration:  BoxDecoration(
          //                  shape: BoxShape.rectangle,
          //                  color: Colors.white,
          //                  border: Border.all(color: Theme.of(context).primaryColor),
          //                  ),
          //                child: Text(options[index],
          //                  style: TextStyle(
          //                    fontSize: 16,
          //                    color: options[index].isEmpty ? Colors.black54 : const Color(0xff38106A),
          //                    fontWeight: FontWeight.bold,
          //                  ),
          //                ),
          //              );
          //                }),
          //    ),
          //  ),
          // ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: serviceProvider.categoryProductByCategoies.length,
                      (context, index){
                  ServiceModel service = serviceProvider.categoryProductByCategoies[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 10),
                    child: Container(
                      height: height*0.1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffF9F9F9),
                      ),
                      child: ListTile(
                        leading: Image.network('${service.image}',
                          alignment: Alignment.center,
                          color: const Color(0xff38106A),
                          height: 38,
                          width:  38,
                        ),
                        title: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text('${service.name}',
                              style: Utils.orderListName),
                            Text(' (${service.serviceType})',
                              style: Utils.textSubtitle),
                          ],
                        ),
                        subtitle: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.start,
                          children: [
                            Text('Rs.${service.price}',
                              style: Utils.headlineTextStyle,),
                            // SizedBox(width: width*0.01),
                            // SizedBox(
                            //   height: height*0.07,
                            //   width: width*0.26,
                            //   child: FormField<String>(
                            //     validator: (value){
                            //       if(value!.isEmpty){
                            //         return "*gender";
                            //       }
                            //       setState(() {
                            //         _category = value;
                            //       });
                            //       return null;
                            //     },
                            //     builder: (FormFieldState<String> state) {
                            //       return InputDecorator(
                            //         decoration: const InputDecoration(
                            //             contentPadding: EdgeInsets.zero,
                            //           border: InputBorder.none,
                            //         ),
                            //         child: DropdownButtonHideUnderline(
                            //           child: DropdownButton<String>(
                            //             icon: const Icon(CupertinoIcons.chevron_down,
                            //               color: Color(0xff38106A),
                            //             ),
                            //             style: Utils.simpleText,
                            //             hint: Text(
                            //               "gender?",
                            //               style: Utils.simpleText,
                            //             ),
                            //             items: categoryList.map<DropdownMenuItem<String>>(
                            //                     (String? value) {
                            //                   return DropdownMenuItem(
                            //                     value: value,
                            //                     child: Row(
                            //                       children: [
                            //                          SizedBox(
                            //                           width: width*0.02,
                            //                         ),
                            //                         Text("$value"),
                            //                       ],
                            //                     ),
                            //                   );
                            //                 }).toList(),
                            //             isExpanded: true,
                            //             isDense: true,
                            //             onChanged: (String? newSelectedBank) {
                            //               _onDropDownItemSelected(newSelectedBank);
                            //             },
                            //             value: _category,
                            //
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                        trailing: AddToCartWidget(
                          service: service,
                          productId: service.productId,
                        ),
                      ),
                    ),
                  );
          }),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: height*0.2),
          ),
        ],
      ),
    );
  }


}