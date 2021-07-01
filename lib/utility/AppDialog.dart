import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/RetryDialog.dart';
import 'package:doctor/values/AppPrefs.dart';
import 'package:doctor/values/AppSetings.dart';
import 'CustomAlertDialog.dart';

class AppDialog
{

  static const int DIALOG_ERROR = 1;
  static const int DIALOG_SUCCESS = 2;
  static const int DIALOG_INFO = 3;


  static void show(BuildContext context,int dialogType,String? description,{String title="",String buttonText=""}){

    if(buttonText.length==0)
    {
      buttonText="Ok";
    }

    String image="";
    if(dialogType==DIALOG_SUCCESS)
      {
        image="images/emoji_happy.svg";
      }
    else if(dialogType==DIALOG_INFO)
      {
        image="images/info_icon.svg";
      }
    else
    {
      image="images/emoji_sad.svg";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: title,
        description:description,
        buttonText: buttonText,
        image: image,
      ),
    );
  }


  static void showImageDialog(BuildContext context,String imageStr){

    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 250,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xffF5C589), Color(0xffE68C1B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
            ),
            border: Border.all(
              width: 0.5,
              color: Color(0xffBE7416),
            ),
            borderRadius: BorderRadius.all(Radius.circular(3))
        ),
        child: Card(
          semanticContainer: true,
          color: AppColors.tiles_bg,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Image.asset(imageStr),
        ),
      ),
    );

  }


  static showErrorDialog(context,title,msg,int? code, {Function()? onRetry}) {
    if(code==401)
      {
        CustomAlertDialog.show(context, AppDialog.DIALOG_ERROR, msg,
            title: "",buttonText: "Ok" ,isNegativeButtonVisible: false,
            negativeButtonText: "",
            onPositiveButtonClicked: ()
            {
              AppPrefs.getInstance()!.setLogout(true);
              Navigator.popUntil(
                context,
                ModalRoute.withName('/home'),
              );
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/login');
            },
            image: "images/emoji_sad.svg");
      }
    else if(code==110 && onRetry!=null)
      {
        showDialog(
          context: context,
          builder: (BuildContext context) => RetryDialog(
            onPositiveButtonClicked: ()
            {
              Navigator.pop(context);
              AppUtill.printAppLog("retrying...");
              onRetry();
            },
          ),
        );
      }
    else
      {
        show(context, DIALOG_ERROR, msg,title: title);
      }
  }

  static showSuccessDialog(context,title,msg) {
    show(context, DIALOG_SUCCESS, msg,title: title);
  }

  static showInfoDialog(context,title,msg) {
    show(context, DIALOG_INFO, msg,title: title);
  }

}