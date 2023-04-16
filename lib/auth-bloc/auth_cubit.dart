import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundary_system/services/user_service.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final auth = FirebaseAuth.instance;
  String? verificationId;
  UserService userService = UserService();
  Timer? _timer;
  int _start = 60;

  AuthCubit() : super(AuthInitialState()){
  User? user = auth.currentUser;
  if(user != null){
    emit(AuthLoggedInState(user));
  }else{
    emit(AuthLogOutState());
   }
  }

  Stream<User?> get user {
    return auth.authStateChanges();
  }
 var number;
  var _resendToken;
  void sendOtp(phoneNumber, context){
    number = phoneNumber;
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential){
          signInWithPhoneNumber(credential, context);
        },
        verificationFailed:  (FirebaseAuthException e){
          // emit(ErrorState(e.message));
          if (e.code == 'invalid-phone-number') {
            emit(ErrorState("The provided phone number is not valid"));
            // Utils.flushBarMessage(context, e.code.toString(), const Color(0xffFF8C00));
            if (kDebugMode) {
              print(e.message);
            }
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(AuthCodeSendState());
          this.verificationId = verificationId;
          _resendToken = resendToken;

        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
        },
    );
  }

  void verifyOTP({otp, context}){
    PhoneAuthCredential phoneAuthProvider = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
    );
    signInWithPhoneNumber(phoneAuthProvider, context);
  }

  Future<void> signInWithPhoneNumber(PhoneAuthCredential credential, context) async{
    try{
     UserCredential userCredential = await auth.signInWithCredential(credential);
     if(userCredential.user != null){
       userService.getUserById(auth.currentUser!.uid).then((value){
         if(value.exists){
           emit(AuthLoggedInState(userCredential.user));
         }else{
           createUser(phoneNumber: number);
         }
       });
     }else {
       emit(AuthFillFormState());
       updateUser(phoneNumber: number);
     }
    } on FirebaseAuthException catch(e){
      Utils.flushBarMessage(context, e.toString(), const Color(0xffFF8C00));
    }
  }

  void resendSendOtp(context){
    auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential){
        signInWithPhoneNumber(credential, context);
      },
      verificationFailed:  (FirebaseAuthException e){
        // emit(ErrorState(e.message));
        if (e.code == 'invalid-phone-number') {
          emit(ErrorState("The provided phone number is not valid"));
          // Utils.flushBarMessage(context, e.code.toString(), const Color(0xffFF8C00));
          if (kDebugMode) {
            print(e.message);
          }
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        emit(AuthCodeSendState());
        this.verificationId = verificationId;
        _resendToken = resendToken;
        _start = 60;
        startTimer();
        print(_start);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
      timeout: const Duration(seconds: 60),
      forceResendingToken: _resendToken,
    );
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        _timer?.cancel();
      } else {
        _start--;
      }
    });
  }

  void logout() async{
    auth.signOut();
    emit(AuthLogOutState());
  }

  createUser({phoneNumber}){
    FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).set({
      "name": null,
      "userId": auth.currentUser?.uid,
      "phoneNumber": phoneNumber,
      "status": null,
      "deliveryAddress": null,
      "deliveryLatitude": null,
      "deliveryLongitude": null,
      "pickUpLatitude": null,
      "pickUpLongitude": null,
      "pickupAddress": null,
      "profile": null,
    });
  }
  updateUser({phoneNumber}){
    FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).update({
      "name": "name",
      "userId": auth.currentUser?.uid,
      "phoneNumber": phoneNumber,
      "status": "status",
    });
  }
}