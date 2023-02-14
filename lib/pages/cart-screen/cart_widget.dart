import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../utils/Utils_widget.dart';
import '../../widgets/cart_counter.dart';

class CartWidget extends StatelessWidget {
  final DocumentSnapshot document;
  const CartWidget({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ListTile(
      tileColor: const Color(0xffF9F9F9),
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
            style: Utils.headlineTextStyle),
          SizedBox(width: width*0.01),
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
          //           contentPadding: EdgeInsets.zero,
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
          //                         SizedBox(
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
      trailing: CartCounter(
        snapshot: document,
      ),
    );
  }
}
