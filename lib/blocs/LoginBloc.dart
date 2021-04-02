import 'dart:async';

import 'package:doctor/data/Database.dart';
import 'package:doctor/model/DoctorListResponseModel.dart';
import 'package:doctor/process/ContactProcess.dart';
import 'package:doctor/ui/DoctorDetailEditScreen.dart';
import 'package:doctor/ui/OTPScreen.dart';
import 'package:doctor/utility/AppDialog.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/Loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoginBloc{

  String phNumber="";
  final _phoneNumberStreamController=StreamController<String>();
  StreamSink<String> get phoneNumberSink =>_phoneNumberStreamController.sink;
  Stream<String> get phoneNumberStream =>_phoneNumberStreamController.stream;


  LoginBloc()
  {
    phoneNumberStream.listen((value) {
      phNumber=value.toString();
      AppUtill.printAppLog("value::${value.toString()}");
    });

  }

  verifyAppNumber(BuildContext context)
  async {
    Loader.showLoader(context);
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: '+91${phNumber}',
      /*verificationCompleted: (PhoneAuthCredential credential) async{
        //only for android

        await auth.signInWithCredential(credential);
        AppUtill.printAppLog("verifyPhoneNumber::verificationCompleted");

      },*/
      verificationFailed: (FirebaseAuthException e) {
        Loader.hideLoader();
        if (e.code == 'invalid-phone-number') {
          AppDialog.showErrorDialog(context, "", "The provided phone number is not valid.", 0);
          print('verifyPhoneNumber::The provided phone number is not valid.');
        }
        else{
          AppDialog.showErrorDialog(context, "", "${e.message}", 0);
        }
        String status = '${e.message}';
        print('verifyPhoneNumber::${e.message}');

      },
      codeSent: (String verificationId, int resendToken) async {
        Loader.hideLoader();
        Navigator.pop(context);
        AppUtill.printAppLog("verifyPhoneNumber::codeSent");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return OTPScreen(phNumber,verificationId,auth);
            }));

        /*String smsCode = 'xxxx';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

        AppUtill.printAppLog("verifyPhoneNumber::codeSent");
        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(phoneAuthCredential);*/
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Loader.hideLoader();
        AppUtill.printAppLog("verifyPhoneNumber::codeAutoRetrievalTimeout:: $verificationId");
      },
    );
  }

}