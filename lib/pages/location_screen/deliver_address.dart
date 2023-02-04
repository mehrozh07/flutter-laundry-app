import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
import 'package:location/location.dart';

enum Address{ Home, Office}
class DeliverAddress extends StatefulWidget {
  const DeliverAddress({Key? key}) : super(key: key);

  @override
  State<DeliverAddress> createState() => _DeliverAddressState();
}

class _DeliverAddressState extends State<DeliverAddress> {
  var addressType = Address.Home;
  LatLng? _latLong;
  bool _locating = false;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  LocationData? _locationData;

  Future<Position> _determinePosition() async {

    bool serviceEnabled;
    LocationPermission permission;
    await Geolocator.requestPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
  Placemark? _placeMark;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  getUserAddress()async{
    List<Placemark> placemarks = await placemarkFromCoordinates(_latLong!.latitude, _latLong!.longitude);
    setState(() {
      _placeMark = placemarks.first;
    });
  }

  @override
  void initState() {
   _determinePosition();
    super.initState();
  }

  var addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 200),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _placeMark!=null ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_locating ?'Locating...': _placeMark!.locality==null ?
                          _placeMark!.subLocality! : _placeMark!.locality!,
                            style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          },
                              child: Text("Done",
                          style: Utils.coloredTextStyle,))
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(_placeMark!.subLocality!, ),
                          Text(_placeMark!.subAdministrativeArea!=null ? '${_placeMark!.subAdministrativeArea!}, ' : ''),
                        ],
                      ),
                      Text('${_placeMark!.administrativeArea!}, ${_placeMark!.country!}, ${_placeMark!.postalCode!}')
                    ],
                  ) : Container(),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 140,
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
                          contentPadding: EdgeInsets.zero,
                          activeColor: Theme.of(context).primaryColor,
                          secondary: const Icon(Icons.home_filled),
                          selectedTileColor: Theme.of(context).primaryColor,
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
                        width: 140,
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
                          contentPadding: EdgeInsets.zero,
                          activeColor: Theme.of(context).primaryColor,
                          secondary: const Icon(Icons.work_outline_rounded),
                          selectedTileColor: Theme.of(context).primaryColor,
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
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMove: (CameraPosition position){
                setState(() {
                  _locating = true;
                  _latLong = position.target;
                });
              },
              onCameraIdle: (){
                setState(() {
                  _locating = false;
                });
                getUserAddress();
              },
            ),
            Align(
                alignment: Alignment.center,
                child: Icon(CupertinoIcons.location_circle_fill,size: 40, color: Theme.of(context).primaryColor,),
            ),
             Center(
              child: SpinKitRipple(
                duration: const Duration(microseconds: 1),
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
