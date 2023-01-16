import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundary_system/models/catogory_model.dart';

class CategoriesProvider extends ChangeNotifier{
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<CategoryModel> _categoriesList = [];
  List<CategoryModel> get categoriesList => _categoriesList;

  Future category() async{
    List<CategoryModel> newList = [];
    CategoryModel? categoryModel;
    QuerySnapshot snapshot = await db.collection('services').get();
    for (QueryDocumentSnapshot element in snapshot.docs) {
      if (element.exists) {
        categoryModel = CategoryModel.fromJson(element.data());
        newList.add(categoryModel);
        notifyListeners();
      }
    }
    _categoriesList = newList;
    notifyListeners();
  }
}