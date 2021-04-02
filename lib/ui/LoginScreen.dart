import 'dart:io';

import 'package:doctor/blocs/LoginBloc.dart';
import 'package:doctor/ui/widgets/HeaderWidgetLight.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController phoneCtrl = TextEditingController();
  LoginBloc _bloc=LoginBloc();

  @override
  void initState() {
    phoneCtrl.addListener(() {onChange();});
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });

    super.initState();
  }

  void onChange()
  {
    _bloc.phoneNumberSink.add(phoneCtrl.text.trim());
    if(phoneCtrl.text.trim().length==10)
      {
        // AppUtill.hideKeyboard(context);
        setState(() {

        });
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
            Align(alignment: Alignment.center,child: CommonUis.getText("ENTER YOUR MOBILE NUMBER", AppColors.white, AppFontSize.size18,weight: AppFontsStyle.BOLD),),

            Padding(padding: EdgeInsets.only(right: 30,left: 30,top: 20),child: Theme(
              data: ThemeData(
                  unselectedWidgetColor: AppColors.white,
                  primaryColor: AppColors.white,
                  accentColor: AppColors.white,
                  hintColor: AppColors.white),
              child:
              TextField(
                autofocus: true,
                readOnly: false,
                decoration: InputDecoration(
                  prefix: CommonUis.getText("+ 91 ", AppColors.themeContrastColorTwo, AppFontSize.size20,weight: AppFontsStyle.BOLD),
                  suffix: GestureDetector(child:Icon(Icons.cancel_outlined,color: AppColors.themeContrastColor,size: 20,), onTap: ()
                  {
                    setState(() {
                      phoneCtrl.text="";
                    });
                  }),
                  isDense: false,
                  focusColor: AppColors.white,
                  fillColor: AppColors.white,
                  hoverColor: AppColors.white,
                  hintText: "Phone number",
                  labelText: "",
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 12, bottom: 10,top: 0),
                  hintStyle: new TextStyle(color: AppColors.themeContrastColorTransparent),
                  labelStyle: new TextStyle(
                    color: AppColors.themeContrastColor,
                    fontFamily: AppFonts.AppFont,
                    fontWeight: AppFontsStyle.REGULAR,),
                ),
                style: TextStyle(
                  fontSize: 20.0,
                  color: AppColors.themeContrastColor,
                  fontFamily: AppFonts.AppFont,
                  fontWeight: AppFontsStyle.BOLD,
                ),
                maxLines: 1,
                maxLength: 10,
                controller: phoneCtrl,
                keyboardType: TextInputType.number,
              ),
            ),),
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.only(right: 15,left: 15,),child: Align(alignment: Alignment.center,child: CommonUis.getText("We will send you an SMS with the verification code to this number", AppColors.white, AppFontSize.size14,weight: AppFontsStyle.REGULAR),),),
            SizedBox(height: 50,),

            AppUtill.isValidMobileNo(phoneCtrl.text)?
            Padding(padding: EdgeInsets.only(right: 65,left: 65),child: CommonUis.getThemeRaisedButton("Continue", () {
              _bloc.verifyAppNumber(context);
            })):
            Padding(padding: EdgeInsets.only(right: 65,left: 65),child: CommonUis.getThemeRaisedButtonDisabled("Continue", () => null)),
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

