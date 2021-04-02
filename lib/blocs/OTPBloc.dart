import 'dart:async';

import 'package:doctor/data/Database.dart';
import 'package:doctor/model/DoctorListResponseModel.dart';
import 'package:doctor/process/ContactProcess.dart';
import 'package:doctor/ui/DoctorDetailEditScreen.dart';
import 'package:doctor/ui/OTPScreen.dart';
import 'package:doctor/utility/AppDialog.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/Loader.dart';
import 'package:doctor/values/AppPrefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OTPBloc{

  String phNumber="";
  final _phoneNumberStreamController=StreamController<String>();
  StreamSink<String> get phoneNumberSink =>_phoneNumberStreamController.sink;
  Stream<String> get phoneNumberStream =>_phoneNumberStreamController.stream;


  OTPBloc()
  {
    phoneNumberStream.listen((value) {
      phNumber=value.toString();
      AppUtill.printAppLog("value::${value.toString()}");
    });

  }

  verifyOTP(BuildContext context,FirebaseAuth auth,String authVerificationId)
  async {
    Loader.showLoader(context);
    String smsCode = phNumber;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: authVerificationId, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(phoneAuthCredential).catchError((error) {
      Loader.hideLoader();
      AppDialog.showErrorDialog(context, "", "Something has gone wrong, please try later", 0);
    }).then((value) {
      Loader.hideLoader();
      if(value!=null && value.user!=null)
      {
        AppUtill.showToast("Authentication successful", context);
        AppPrefs.getInstance().setLogin();
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/home');

      }
      else {
        AppDialog.showErrorDialog(context, "", "Invalid code/invalid authentication", 0);
      }
    }
    );
  }

}