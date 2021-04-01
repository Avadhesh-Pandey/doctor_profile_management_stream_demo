import 'dart:async';

import 'package:doctor/model/DoctorListResponseModel.dart';
import 'package:doctor/network/Apis.dart';
import 'package:doctor/ui/widgets/CommonWebView.dart';
import 'package:doctor/ui/widgets/HeaderWidgetLight.dart';
import 'package:doctor/utility/AppDialog.dart';
import 'package:doctor/utility/DateTimeConverter.dart';
import 'package:doctor/utility/Loader.dart';
import 'package:doctor/values/AppPrefs.dart';
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

class DoctorDetailScreen extends StatefulWidget {
  DoctorListResponseModel _doctor;

  DoctorDetailScreen(this._doctor);



  @override
  State<StatefulWidget> createState() {
    return DoctorDetailWidget();
  }
}

class DoctorDetailWidget extends State<DoctorDetailScreen> {
  Size _size;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.themeColor,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      color: AppColors.themeColor,
                      child: Column(
                        children: [
                          HeaderWidgetLight("",exitApp: false,),
                          SizedBox(height: 20,),
                          Container(
                            padding: EdgeInsets.only(top: 40),
                            decoration: CommonUis.getBoxDecorationTopCurved(),
                            child: Column(
                              children: [
                                Align(alignment: Alignment.center,child: CommonUis.getText("${widget._doctor.first_name} ${widget._doctor.last_name}", AppColors.black, AppFontSize.size16,weight: AppFontsStyle.BOLD),),
                                Padding(padding: EdgeInsets.only(top: 15,bottom: 15),child: SizedBox(width: 150,height: 30,child: CommonUis.getThemeRaisedButton("EDIT PROFILE", () {

                                }),),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        color: AppColors.greyBoxLight,
                        child:ListView(
                          children: [
                            SizedBox(height: 10,),
                            Align(alignment: Alignment.center,child: CommonUis.getText("PERSONAL DETAILS", AppColors.black, AppFontSize.size16,weight: AppFontsStyle.BOLD),),
                            SizedBox(height: 10,),
                            getDetailsTiles("FIRST NAME", widget._doctor.first_name),
                            getDetailsTiles("LAST NAME", widget._doctor.last_name),
                            getDetailsTiles("GENDER", "MALEee"),
                            getDetailsTiles("CONTACT NUMBER", "${widget._doctor.primary_contact_no}"),
                            Padding(padding: EdgeInsets.only(left: 10,top: 10,bottom: 10),child: CommonUis.getText("DATE OF BIRTH", AppColors.greyTxt, AppFontSize.size14,weight: AppFontsStyle.BOLD),),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                getSmallTiles("DAY", DateTimeConverter.convert(widget._doctor.dob,outputFormat: "dd",inputFormat: "yyyy-MM-dd"), Icons.calendar_today),
                                getSmallTiles("MONTH", DateTimeConverter.convert(widget._doctor.dob,outputFormat: "MMM",inputFormat: "yyyy-MM-dd"), Icons.calendar_today),
                                getSmallTiles("YEAR", DateTimeConverter.convert(widget._doctor.dob,outputFormat: "yyyy",inputFormat: "yyyy-MM-dd"), Icons.calendar_today),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                getSmallTiles("BLOOD GROUP", "${widget._doctor.blood_group}", Icons.thermostat_rounded),
                                getSmallTiles("HEIGHT", "${widget._doctor.height}", Icons.height),
                                getSmallTiles("WEIGHT", "${widget._doctor.weight}", Icons.line_weight),
                              ],
                            ),
                            SizedBox(height: 20,),


                          ],
                        )
                      ),
                    )




                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(padding: EdgeInsets.all(2),
                    margin: EdgeInsets.only(top: 20),
                    child: CommonUis.getCircularImageAvatar(widget._doctor.profile_pic, 70, 70),
                    decoration:BoxDecoration(color: Colors.white, shape: BoxShape.circle),

                  ),),
              ],
            )),
      ),
    );
  }

  Container getDetailsTiles(String title,String content)
  {
    return Container(
      color: AppColors.white,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonUis.getText("${title}", AppColors.greyTxt, AppFontSize.size14,weight: AppFontsStyle.REGULAR),
          SizedBox(height: 8,),
          CommonUis.getText("${content}", AppColors.black, AppFontSize.size14,weight: AppFontsStyle.REGULAR),
        ],
      ),
    );
  }

  Container getSmallTiles(String title,String content,IconData icon)
  {
    return Container(
      width: AppUtill.getSize(_size.width, 30),
      color: AppColors.white,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(top: 15,bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,size: 15,color: AppColors.greyTxt,),
              SizedBox(width: 5,),
              CommonUis.getText("${title}", AppColors.greyTxt, AppFontSize.size14,weight: AppFontsStyle.REGULAR),
            ],
          ),
          SizedBox(height: 8,),
          CommonUis.getText("${content}", AppColors.black, AppFontSize.size14,weight: AppFontsStyle.REGULAR),
        ],
      ),
    );
  }
}
