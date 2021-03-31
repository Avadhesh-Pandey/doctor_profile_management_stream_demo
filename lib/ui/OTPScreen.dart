import 'dart:async';

import 'package:doctor/network/Apis.dart';
import 'package:doctor/ui/widgets/CommonWebView.dart';
import 'package:doctor/ui/widgets/HeaderWidgetLight.dart';
import 'package:doctor/utility/AppDialog.dart';
import 'package:doctor/utility/Loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/CommonUIs.dart';
import 'package:doctor/values/AppSetings.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:toast/toast.dart';

class OTPScreen extends StatefulWidget {
  String phone,authVerificationId;
  FirebaseAuth auth;

  OTPScreen(this.phone,this.authVerificationId,this.auth);

  @override
  State<StatefulWidget> createState() {
    return OTPWidget();
  }
}

class OTPWidget extends State<OTPScreen> {
  Size _size;
  int timeLeft = 60;
  Timer _timer;
  bool checkValue = true;
  TextEditingController phoneCtrl = TextEditingController();

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (this.mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    if (timeLeft > 0) {
      timeLeft--;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.themeColor,
      ),
      child: Scaffold(
        backgroundColor: AppColors.themeColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.themeColor,
          automaticallyImplyLeading: false,
          title: HeaderWidgetLight("",exitApp: true,),
        ),
        body: SafeArea(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text("Enter Verification Code",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: AppFontSize.size18,
                        color: AppColors.white,
                        fontFamily: AppFonts.AppFont,
                        fontWeight: AppFontsStyle.BOLD)),


                Container(
                  color: AppColors.themeColor,
                  margin: EdgeInsets.only(left: 0, right: 0, top: 20,bottom: 20),
                  width: 300,
                  child: Theme(
                    data: ThemeData(
                        primaryColor: AppColors.white,
                        accentColor: AppColors.white,
                        hintColor: AppColors.white),
                    child:
                    Padding(
                        padding: EdgeInsets.only(left: 40,right: 40),
                        child: PinCodeTextField(
                          backgroundColor: AppColors.themeColor,
                          errorTextSpace: 0,
                          length: 6,
                          obsecureText: false,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v.length < 3) {
                              return "I'm from validator";
                            } else {
                              return null;
                            }
                          },
                          textInputType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          textStyle: TextStyle(
                              fontSize: AppFontSize.size12,
                              color: AppColors.white,
                              fontFamily: AppFonts.AppFont,
                              fontWeight: AppFontsStyle.BOLD),
                          pinTheme: PinTheme(
                            selectedFillColor: AppColors.themeColorDark,
                            inactiveFillColor: AppColors.themeColorDark,
                            inactiveColor: AppColors.themeColorDark,
                            activeColor: AppColors.themeColorDark,
                            selectedColor: AppColors.textColor,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 45,
                            fieldWidth: 40,
                            activeFillColor:AppColors.themeColorDark,
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          autoDisposeControllers: false,
                          controller: phoneCtrl,
                          onCompleted: (v) {
                            print("Completed");
                          },
                          onChanged: (value) {
                            print(value);
                            setState(() {
//                                      currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),
                  ),
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Please enter the verification code that was sent to",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: AppColors.white,
                          fontFamily: AppFonts.AppFont,
                          fontWeight: AppFontsStyle.REGULAR),
                      children: <TextSpan>[
                        TextSpan(
                          text: "\n+91-${widget.phone}.",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.white,
                              fontFamily: AppFonts.AppFont,
                              fontWeight: AppFontsStyle.BOLD),
                        ),
                      ],
                    )),

                Padding(
                  padding: EdgeInsets.only(right: 30,left: 30,top: 100,bottom: 0),
                  child: CommonUis.getThemeRaisedButton("Login", () {
                    if(!checkValue)
                      {
                        AppDialog.showInfoDialog(context, "", "Please agree to the Term Of Use and Privacy Policy");
                        return;
                      }
                    verifyOTP(context);
                  }),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(width: 40,),
                    Checkbox(
                      value: checkValue,
                      onChanged: (value) {
                        setState(() {
                          checkValue = value;
                        });
                      },
                      activeColor: AppColors.themeContrastColorTwo,
                    ),
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AppColors.white,
                                fontFamily: AppFonts.AppFont,
                                fontWeight: AppFontsStyle.REGULAR),
                            children: <TextSpan>[
                              TextSpan(
                                recognizer: new TapGestureRecognizer()..onTap = () {
                                  AppUtill.printAppLog("TapGestureRecognizer");
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return CommonWebView(Apis.privacy_url,"Term Of Use");
                                      }));
                                },
                                text: "Term Of Use",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColors.themeContrastColor,
                                    fontFamily: AppFonts.AppFont,
                                    fontWeight: AppFontsStyle.REGULAR),
                              ),
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColors.white,
                                    fontFamily: AppFonts.AppFont,
                                    fontWeight: AppFontsStyle.REGULAR),
                              ),
                              TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColors.themeContrastColor,
                                    fontFamily: AppFonts.AppFont,
                                    fontWeight: AppFontsStyle.REGULAR),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    AppUtill.printAppLog("TapGestureRecognizer");
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return CommonWebView(Apis.privacy_url,"Privacy Policy ");
                                        }));
                                  },
                              ),
                            ],
                          )),
                      flex: 1,
                    ),
                    SizedBox(width: 40,),
                  ],
                ),
/*                SizedBox(height: 60,),
                RaisedButton(
                    color: AppColors.themeColor,
                    padding: EdgeInsets.all(0.0),
                    elevation: 0,
                    child:
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Did not get it",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.white,
                              fontFamily: AppFonts.AppFont,
                              fontWeight: AppFontsStyle.REGULAR),
                          children: <TextSpan>[
                            TextSpan(
                              text: timeLeft>0?" ${"Wait"} | $timeLeft" : " ${"Resend OTP"}",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppColors.themeContrastColor,
                                  fontFamily: AppFonts.AppFont,
                                  fontWeight: AppFontsStyle.BOLD),
                            ),
                          ],
                        )),

                    onPressed: () {
                      if (timeLeft <= 0) {
                        *//*OTPProcess().resendOtp((apiResponse) {
                                          AppUtill.printAppLog(
                                              "message ==${apiResponse.msg}");
                                          timeLeft = 60;
                                        }, widget.phone);*//*
                      }
                    }),*/
                SizedBox(
                  height: 20,
                )
              ],
            )),
      ),
    );
  }

  verifyOTP(BuildContext context)
  async {
    Loader.showLoader(context);

    String smsCode = phoneCtrl.text;
    
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: widget.authVerificationId, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await widget.auth.signInWithCredential(phoneAuthCredential).catchError((error) {
      Loader.hideLoader();
      AppDialog.showErrorDialog(context, "", "Something has gone wrong, please try later", 0);
    }).then((value) {
      Loader.hideLoader();
      if(value!=null && value.user!=null)
      {
        // AppUtill.printAppLog("${value.user.displayName} ${AppUtill.printClass(value.user)}");
        AppDialog.showSuccessDialog(context, "", "Authentication successful",);
      }
      else {
        AppDialog.showErrorDialog(context, "", "Invalid code/invalid authentication", 0);
        // AppUtill.printAppLog("ERROR:: ${AppUtill.printClass(value.user)}");

      }
    }
      );
  }
}
