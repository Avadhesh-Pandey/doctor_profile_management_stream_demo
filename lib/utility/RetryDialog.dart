
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/values/AppSetings.dart';

import 'CommonUIs.dart';

class RetryDialog extends StatelessWidget {
  final Function() onPositiveButtonClicked;

  static void show(BuildContext context,Map<String,dynamic> notificationMap,{String image="images/notification_bell.svg",String buttonText="",Function() onPositiveButtonClicked,Function() onNegativeButtonClicked,bool isNegativeButtonVisible=false,String negativeButtonText=""}){

    if(buttonText.length==0)
    {
      buttonText="Ok";
    }
    if(!AppUtill.isValid(negativeButtonText))
    {
      negativeButtonText="Cancel";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => RetryDialog(
        onPositiveButtonClicked: onPositiveButtonClicked,
      ),
    );
  }

  RetryDialog({
    this.onPositiveButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
  dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Consts.padding,
        bottom: Consts.padding,
        left: Consts.padding,
        right: Consts.padding,
      ),
      decoration: new BoxDecoration(
        color: AppColors.transparent,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Icon(Icons.wifi_off,color: AppColors.themeContrastColor,size: 50,),
          Padding(
            padding: EdgeInsets.only(top: 20,bottom: 0),
            child: Text(
              "No Internet Connection",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: AppFontSize.size20,
                  color: AppColors.white,
                  fontFamily: AppFonts.AppFont,
                  fontWeight: AppFontsStyle.MEDIUM),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            "Please check your network connectivity and try again.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: AppFontSize.size14,
                color: AppColors.white,
                fontFamily: AppFonts.AppFont,
                fontWeight: AppFontsStyle.LIGHT),
          ),
          SizedBox(height: 40.0),
          CommonUis.getThemeRaisedButtonNegative("Retry", () {
            if(onPositiveButtonClicked==null)
            {
              Navigator.of(context).pop(); // To close the dialog
            }
            else
            {
              onPositiveButtonClicked();
            }

          },height: 45),
        ],
      ),
    );
  }

}
class Consts {
  Consts._();

  static const double padding = 35.0;
  static const double avatarRadius = 30.0;
}