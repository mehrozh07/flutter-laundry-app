import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/models/service_model.dart';

class ServiceProvider extends ChangeNotifier{
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<ServiceModel> _serviceList = [];
  List<ServiceModel> get serviceList => _serviceList;

  Future getService() async{
    List<ServiceModel> newList = [];

    ServiceModel? serviceModel;
    QuerySnapshot querySnapshot = await db.collection('products').get();

    for(QueryDocumentSnapshot snapshot in querySnapshot.docs){
      if(snapshot.exists){
        serviceModel = ServiceModel.fromJson(snapshot.data());
        newList.add(serviceModel);
        notifyListeners();
      }
    }
    _serviceList = newList;
    notifyListeners();
  }

  List<ServiceModel> _categoryByProduct = [];

  List<ServiceModel> get categoryProductByCategoies => _categoryByProduct;

  Future getProductByCategory(String catName) async{
    List<ServiceModel> catgory = [];
    QuerySnapshot snapshot = await db.collection('products').get();
    ServiceModel productModel;
    for (QueryDocumentSnapshot element in snapshot.docs) {
      if (element.exists) {
        if(catName== element['serviceType']){
          productModel = ServiceModel.fromJson(element.data());
          catgory.add(productModel);
          notifyListeners();
        }
      }
    }
    _categoryByProduct = catgory;
    notifyListeners();
  }
}