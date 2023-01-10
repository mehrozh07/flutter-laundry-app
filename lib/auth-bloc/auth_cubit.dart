import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundary_system/utils/Utils_widget.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final auth = FirebaseAuth.instance;
  String? verificationId;

  AuthCubit() : super(AuthInitialState()){
  User? user = auth.currentUser;
  if(user != null){
    emit(AuthLoggedInState(user));
  }else{
    emit(AuthLogOutState());
  }
  }

  void sendOtp(phoneNumber, context){
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential){
          signInWithPhoneNumber(credential, context);
        },
        verificationFailed:  (FirebaseAuthException e){
          emit(ErrorState(e.message));
          if (e.code == 'invalid-phone-number') {
            Utils.flushBarMessage(context, e.code.toString(), const Color(0xffFF8C00));
            if (kDebugMode) {
              print('The provided phone number is not valid.');
            }
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(AuthCodeSendState());
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
        },
    );
  }

  void verifyOTP(otp, context){
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
       emit(AuthLoggedInState(userCredential.user));
     }
    } on FirebaseAuthException catch(e){
      Utils.flushBarMessage(context, e.toString(), const Color(0xffFF8C00));
    }
  }

  void logout() async{
    auth.signOut();
    emit(AuthLogOutState());
  }
}