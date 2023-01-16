import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/generated/assets.dart';
import 'package:laundary_system/route_names.dart';
import 'package:laundary_system/utils/Utils_widget.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> with SingleTickerProviderStateMixin{
  TabController? _tabController;

  List<String> options = [
    'Wash', 'Ironing', 'Fold',
    'Dry', 'Clean', 'Wash&Dry','Wash&Ironing', "Ironing&Clean",
  ];
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
    _tabController = TabController(length: 8, vsync: this);
    super.initState();
  }
  int i = 0;
  int tag = 0;
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
           SliverAppBar(
             automaticallyImplyLeading: false,
           flexibleSpace: Container(
             height: height*0.06,
             decoration: const BoxDecoration(
               color: Colors.white,
             ),
             child: TabBar(
               controller: _tabController,
               onTap: (value){
                 if(value == 0){
                   setState(() {

                   });
                 }
                 setState(() {
                   tag = value;

                 });
               },
               dragStartBehavior: DragStartBehavior.start,
               padding: EdgeInsets.zero,
               automaticIndicatorColorAdjustment: true,
               physics: const BouncingScrollPhysics(),
               indicatorWeight: 0.1,
               isScrollable: true,
               labelColor: Colors.black,
               indicatorColor: const Color(0xff38106A),
               unselectedLabelColor: const Color(0xff38106A),
               indicatorSize: TabBarIndicatorSize.label,
                 tabs: List.generate(
                     options.length,
                         (index) {
                       return Container(
                           padding: const EdgeInsets.only(left: 4, right: 4,top: 2,bottom: 2),
                           decoration:  BoxDecoration(
                           shape: BoxShape.rectangle,
                           color: Colors.white,
                           border: Border.all(color: Theme.of(context).primaryColor),
                           ),
                         child: Text(options[index],
                           style: TextStyle(
                             fontSize: 16,
                             color: options[index].isEmpty ? Colors.black54 : const Color(0xff38106A),
                             fontWeight: FontWeight.bold,
                           ),),
                       );
                         }),
             ),
           ),
          ),
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
                      child: ListTile(
                        leading: Image.network('https://cdn-icons-png.flaticon.com/512/20/20092.png',
                          color: const Color(0xff38106A),
                          height: 38,width: 38,),
                        title: Text('T-Shirt', style: Utils.orderListName,),
                        subtitle: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.start,
                          children: [
                            Text('\$5', style: Utils.headlineTextStyle,),
                            SizedBox(width: width*0.01,),
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
                                        icon: const Icon(CupertinoIcons.chevron_down),
                                        style: Utils.simpleText,
                                        hint: Text(
                                          "mm",
                                          style: Utils.simpleText,
                                        ),
                                        items: categoryList
                                            .map<DropdownMenuItem<String>>(
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
                            // Text('Men', style: Utils.simpleText,),
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
                                onPressed: (){
                                  setState(() {
                                    i--;
                                  });
                                },
                                icon: const Icon(CupertinoIcons.minus),
                              ),
                            ),
                            SizedBox(width: width*0.01,),
                            Text('$i',style: Utils.itemCount,),
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
                                  onPressed: (){
                                    setState(() {
                                      i++;
                                    });
                                  },
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