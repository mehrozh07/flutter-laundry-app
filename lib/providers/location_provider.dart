import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundary_system/Repositry/Data-Repositry/firebase_api.dart';


enum Address{Home, Office}
class LocationProvider extends ChangeNotifier{

  final Completer<GoogleMapController> _controller = Completer();
  double? _latitude;
  double? get latitude => _latitude;
  double? _longitude;
  double? get longitude => _longitude;
  FirebaseApi firebaseApi = FirebaseApi();
  Placemark? _placeMark;
  Placemark? get placeMark  => _placeMark;
   LatLng _latLong = LatLng(37.42796133580664, -122.085749655962);
  LatLng get latLng => _latLong;
  Position? _position;
  Position? get position => _position;
  // set setPosition(Position position){
  //   _position = position;
  //   notifyListeners();
  // }


  set latLong(LatLng setLatLang){
    _latLong = setLatLang;
    notifyListeners();
  }

   bool _locating = false;
   bool get loader => _locating;
   set indicator(bool locating){
     _locating = locating;
     notifyListeners();
   }



  Future<Position> determinePosition() async {

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

  void getUserAddress() async{
     _position = await GeolocatorPlatform.instance.getCurrentPosition(
         locationSettings: const LocationSettings(accuracy: LocationAccuracy.high));

    if(_latLong !=null){
       _latitude = _latLong.latitude;
       _longitude = _latLong.longitude;
       notifyListeners();
     }
    List<Placemark> placemarks = await placemarkFromCoordinates(_latLong.latitude, _latLong.longitude);
    _placeMark = placemarks.first;
    notifyListeners();
  }

  Future<void> onCameraMove(CameraPosition cameraPosition) async {
    _latitude = cameraPosition.target.latitude;
    _longitude = cameraPosition.target.longitude;
    notifyListeners();
  }

  updateUser(){
    firebaseApi.user.doc(FirebaseAuth.instance.currentUser?.uid).update({
      "deliveryLatitude": _latLong.latitude,
    });
    notifyListeners();
  }
}