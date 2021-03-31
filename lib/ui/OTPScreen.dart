import 'dart:async';

import 'package:doctor/ui/widgets/HeaderWidgetLight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/CommonUIs.dart';
import 'package:doctor/values/AppSetings.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:toast/toast.dart';

class OTPScreen extends StatefulWidget {
  String phone;

  OTPScreen(this.phone);

  @override
  State<StatefulWidget> createState() {
    return OTPWidget();
  }
}

class OTPWidget extends State<OTPScreen> {
  Size _size;
  int timeLeft = 60;
  Timer _timer;
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
        body: SafeArea(
            child: Container(
              color: AppColors.themeColor,
              child: Column(
                children: <Widget>[
                  HeaderWidgetLight("",exitApp: true,),
                  Flexible(
                      child: ListView(
                        children: <Widget>[
                          Container(
                            child: SvgPicture.asset("images/house_leasing.svg"),
                            height: _size.height/4,
                          ),
                          Container(
                            height: _size.height-(_size.height/4),
                            decoration: CommonUis.getBoxDecorationTopCurved(),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Enter Verification Code",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: AppFontSize.size24,
                                        color: AppColors.blackTxt,
                                        fontFamily: AppFonts.AppFont,
                                        fontWeight: AppFontsStyle.MEDIUM)),
                                SizedBox(
                                  height: 5,
                                ),
                                RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "Waiting for OTP",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: AppColors.blackTxt,
                                          fontFamily: AppFonts.AppFont,
                                          fontWeight: AppFontsStyle.REGULAR),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "\n+91-${widget.phone}.",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColors.black,
                                              fontFamily: AppFonts.AppFont,
                                              fontWeight: AppFontsStyle.MEDIUM),
                                        ),
                                      ],
                                    )),

                                Container(
                                  margin: EdgeInsets.only(left: 0, right: 0, top: 40,bottom: 40),
                                  child: Theme(
                                    data: ThemeData(
                                        primaryColor: AppColors.black,
                                        accentColor: AppColors.black,
                                        hintColor: AppColors.black),
                                    child:
                                    Padding(
                                        padding: EdgeInsets.only(left: 40,right: 40),
                                        child: PinCodeTextField(
                                          errorTextSpace: 0,
                                          length: 4,
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
                                              color: AppColors.blackTxt,
                                              fontFamily: AppFonts.AppFont,
                                              fontWeight: AppFontsStyle.MEDIUM),
                                          pinTheme: PinTheme(
                                            selectedFillColor: AppColors.textFieldBG,
                                            inactiveFillColor: AppColors.textFieldBG,
                                            inactiveColor: AppColors.themeColorDark,
                                            activeColor: AppColors.textFieldBG,
                                            selectedColor: AppColors.themeColorDark,
                                            shape: PinCodeFieldShape.box,
                                            borderRadius: BorderRadius.circular(20),
                                            fieldHeight: 45,
                                            fieldWidth: 55,
                                            activeFillColor:Colors.white,
                                          ),
                                          animationDuration: Duration(milliseconds: 300),
                                          enableActiveFill: true,
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
                                Padding(
                                  padding: EdgeInsets.only(right: 30,left: 30,top: 20),
                                  child: CommonUis.getThemeRaisedButton("Login", () => null),
                                ),
                                SizedBox(height: 60,),
                                RaisedButton(
                                    color: AppColors.white,
                                    padding: EdgeInsets.all(0.0),
                                    elevation: 0,
                                    child: /*ButtonsWidget.getThemeNegativeButton(timeLeft > 0 ? "${AppLocalizations.of(context).translate("wait_OTP")} | $timeLeft" : "${AppLocalizations.of(context).translate("resend_OTP")}"),*/
                                    RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: "Did not get it",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColors.blackTxt,
                                              fontFamily: AppFonts.AppFont,
                                              fontWeight: AppFontsStyle.REGULAR),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: timeLeft>0?" ${"Wait"} | $timeLeft" : " ${"Resend OTP"}",
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: AppColors.themeColor,
                                                  fontFamily: AppFonts.AppFont,
                                                  fontWeight: AppFontsStyle.MEDIUM),
                                            ),
                                          ],
                                        )),

                                    onPressed: () {
                                      if (timeLeft <= 0) {
                                        /*OTPProcess().resendOtp((apiResponse) {
                                          AppUtill.printAppLog(
                                              "message ==${apiResponse.msg}");
                                          timeLeft = 60;
                                        }, widget.phone);*/
                                      }
                                    }),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          )
                        ],
                      )),

                ],
              ),
            )),
      ),
    );
  }
}
