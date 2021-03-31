import 'dart:io';

import 'package:doctor/ui/widgets/CommonWebView.dart';
import 'package:doctor/ui/widgets/HeaderWidgetLight.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doctor/network/Apis.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/CommonUIs.dart';
import 'package:doctor/values/AppSetings.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginWidget();
  }
}


class LoginWidget extends State<LoginScreen> {
  Size _size;
  bool checkValue = true;
  TextEditingController phoneCtrl = TextEditingController();

  @override
  void initState() {
    phoneCtrl.addListener(() {onChange();});

    super.initState();
  }

  void onChange()
  {
    if(phoneCtrl.text.trim().length==10)
      {
        AppUtill.hideKeyboard(context);
      }

  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return WillPopScope(child:
    AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
      ),
      child: Scaffold(
        backgroundColor: AppColors.themeColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.themeColor,
          automaticallyImplyLeading: false,
          title: HeaderWidgetLight("",exitApp: true,),
        ),
        body: ListView(
          shrinkWrap: false,
          children: <Widget>[
            Image.asset("images/bima_logo.png",fit: BoxFit.contain,width: 60,height: 60,color: AppColors.white,),
            SizedBox(height: 50,),
            Align(alignment: Alignment.center,child: CommonUis.getText("ENTER YOUR MOBILE NUMBER", AppColors.white, AppFontSize.size16,weight: AppFontsStyle.MEDIUM),),
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.only(right: 50,left: 50),child: CommonUis.getCommonTextField(text: "Phone Number",controller: phoneCtrl,maxLength: 10,textInputType: TextInputType.number,),),
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.only(right: 15,left: 15,),child: Align(alignment: Alignment.center,child: CommonUis.getText("We will send you an SMS with the verification code to this number", AppColors.white, AppFontSize.size14,weight: AppFontsStyle.REGULAR),),),
            Row(
              children: <Widget>[
                SizedBox(width: 20,),
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
                SizedBox(width: 20,),
              ],
            ),
            SizedBox(height: 50,),

            Padding(padding: EdgeInsets.only(right: 65,left: 65),child: CommonUis.getThemeRaisedButton("Continue", () => null)),

            SizedBox(height: 10,),


          ],
        ),
      ),

    ), onWillPop: (){
      Navigator.pop(context);
      exit(0);
    });
  }
}
