import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundary_system/Repositry/Data-Repositry/firebase_api.dart';
import 'package:laundary_system/providers/location_provider.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import 'package:provider/provider.dart';

enum Address{ Home, Office}
class DeliverAddress extends StatefulWidget {
  const DeliverAddress({Key? key}) : super(key: key);

  @override
  State<DeliverAddress> createState() => _DeliverAddressState();
}

class _DeliverAddressState extends State<DeliverAddress> {
  var addressType = Address.Home;
  FirebaseApi firebaseApi = FirebaseApi();
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );



  @override
  void initState() {
    var locationProvider = Provider.of<LocationProvider>(context, listen: false);
   locationProvider.getUserAddress();
    super.initState();
  }

  var addressController = TextEditingController();
  LatLng currentLocation =  LatLng(37.42796133580664, -122.085749655962);
  @override
  Widget build(BuildContext context) {
    var locationProvider = Provider.of<LocationProvider>(context);
    setState(() {
      currentLocation = LatLng(locationProvider.position!.latitude, locationProvider.position!.longitude);
    });
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, MediaQuery.of(context).size.height*0.22),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  locationProvider.placeMark !=null ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(locationProvider.loader ?'Locating...': locationProvider.placeMark!.locality==null ?
                          locationProvider.placeMark!.subLocality! : locationProvider.placeMark!.locality!,
                            style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                        locationProvider.loader ? const Text("Locating...") :
                        TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              minimumSize: const Size(50, 50),
                            ),
                              onPressed: (){
                              firebaseApi.user.doc(FirebaseAuth.instance.currentUser?.uid).update({
                                "deliveryAddress": locationProvider.address,
                                "deliveryLatitude": locationProvider.latitude,
                                "deliveryLongitude": locationProvider.longitude,
                              });
                            Navigator.of(context).pop();
                          },
                              child: Text("Done",
                          style: Utils.headlineTextStyle))
                        ],
                      ),
                      Row(
                        children: [
                          Text(locationProvider.placeMark!.subLocality!, ),
                          Text(locationProvider.placeMark!.subAdministrativeArea!=null
                              ? '${locationProvider.placeMark!.subAdministrativeArea!}, ' : ''),
                        ],
                      ),
                      Text('${locationProvider.placeMark!.administrativeArea!},'
                          ' ${locationProvider.placeMark!.country!}, ${locationProvider.placeMark!.postalCode!}')
                    ],
                  ) : Container(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.45,
                        height: 40,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Theme.of(context).primaryColor
                            )),
                        child: RadioListTile<Address>(
                          visualDensity: const VisualDensity(vertical: -4.0, horizontal: -4),
                          contentPadding: const EdgeInsets.only(right: 5),
                          activeColor: Theme.of(context).primaryColor,
                          secondary: const Icon(Icons.home_filled),
                          selected: true,
                          title: const Text("Home"),
                          value: Address.Home,
                          groupValue: addressType,
                          onChanged: (Address? value) {
                            setState(() {
                              addressType = value!;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.45,
                        height: 40,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Theme.of(context).primaryColor
                            )),
                        child: RadioListTile<Address>(
                          visualDensity: const VisualDensity(vertical: -4.0, horizontal: -4),
                          contentPadding: const EdgeInsets.only(right: 5),
                          activeColor: Theme.of(context).primaryColor,
                          secondary: const Icon(Icons.work_outline_rounded),
                          selected: true,
                          title: const Text("Office"),
                          value: Address.Office,
                          groupValue: addressType,
                          onChanged: (Address? value) {
                            setState(() {
                              addressType = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.terrain,
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 14,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMove: (CameraPosition position){
                locationProvider.indicator = true;
                locationProvider.latLong = position.target;
              },
              onCameraIdle: (){
                locationProvider.indicator = false;
                locationProvider.getUserAddress();
              },
            ),
            Align(
                alignment: Alignment.center,
                child: Icon(CupertinoIcons.location_circle_fill,size: 40, color: Theme.of(context).primaryColor,),
            ),
             Center(
              child: SpinKitRipple(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                size: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
