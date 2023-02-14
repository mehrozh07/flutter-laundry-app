import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundary_system/utils/Utils_widget.dart';

class UserProvider extends ChangeNotifier{

  DocumentSnapshot? documentSnapshot;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<DocumentSnapshot> getUserData() async{
    DocumentSnapshot result = await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser?.uid).get();
    documentSnapshot = result;
    notifyListeners();
    return result;
  }

  bool isPickAvail = false;
  File? image;
  // File? get image => _image;
  String pickerError = '';
  String? productUrl;

  Future<String> uploadProfileImage(String filePath, userName) async{
    File? file = File(filePath);
    var timeStamp = Timestamp.now().millisecondsSinceEpoch;
    FirebaseStorage storage = FirebaseStorage.instance;
    try{
      await storage.ref("profileImage/$timeStamp").putFile(file);
    } on FirebaseAuthException catch(e){
      if (kDebugMode) {
        print(e.code);
      }
    }
    String? downloadUrl = await storage.ref("profileImage/$timeStamp").getDownloadURL();
    productUrl = downloadUrl;
    return downloadUrl;
  }

  Future<File?> pickImageGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery, imageQuality: 20);
    if(pickedImage != null){
      final pickedImageFile = File(pickedImage.path);
      image = pickedImageFile;
      notifyListeners();
    }else{
      Utils.flushBarMessage(context, "Select Image!", Colors.redAccent);
      notifyListeners();
    }
    return image;
  }

   String? _adminToken;
  String? get adminToken => _adminToken;

  getAdminToken(){
    FirebaseFirestore.instance
        .collection('admins')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        _adminToken = doc['adminToken'];
        notifyListeners();
      }
    });
  }
}