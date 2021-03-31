
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/values/AppSetings.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title, description, buttonText,negativeButtonText;
  final String image;
  bool isNegativeButtonVisible=false;
  final Function() onPositiveButtonClicked;
  final Function() onNegativeButtonClicked;

  static void show(BuildContext context,int dialogType,String description,{String image="images/emoji_happy.svg",String title="",String buttonText="",Function() onPositiveButtonClicked,Function() onNegativeButtonClicked,bool isNegativeButtonVisible=false,String negativeButtonText=""}){

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
      builder: (BuildContext context) => CustomAlertDialog(
        title: title,
        description:description,
        buttonText: buttonText,
        negativeButtonText: negativeButtonText,
        onNegativeButtonClicked: onNegativeButtonClicked,
        onPositiveButtonClicked: onPositiveButtonClicked,
        isNegativeButtonVisible: isNegativeButtonVisible,
        image: image,
      ),
    );
  }

  CustomAlertDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.negativeButtonText,
    this.onNegativeButtonClicked,
    this.onPositiveButtonClicked,
    this.isNegativeButtonVisible,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              title.length>0?
              Text(
                title,
                style: TextStyle(
                    fontSize: AppFontSize.size20,
                    color: AppColors.blackTxt,
                    fontFamily: AppFonts.AppFont,
                    fontWeight: AppFontsStyle.BOLD),
              ):SizedBox(height: 0,),
              SizedBox(height: 8.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: AppFontSize.size14,
                    color: AppColors.blackTxt,
                    fontFamily: AppFonts.AppFont,
                    fontWeight: AppFontsStyle.BOLD),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Visibility(
                    child: FlatButton(
                      onPressed: () {
                        if(onNegativeButtonClicked==null)
                        {
                          Navigator.of(context).pop(); // To close the dialog
                        }
                        else
                        {
                          onNegativeButtonClicked();
                        }
                      },
                      child: Text(negativeButtonText==null?"":negativeButtonText,
                        style: TextStyle(
                            fontSize: AppFontSize.size16,
                            color: AppColors.themeColor,
                            fontFamily: AppFonts.AppFont,
                            fontWeight: AppFontsStyle.BOLD),),
                    ),
                    visible: isNegativeButtonVisible==null?false:isNegativeButtonVisible,
                  ),
                  Expanded(child: Text(""),flex: 1,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        if(onPositiveButtonClicked==null)
                        {
                          Navigator.of(context).pop(); // To close the dialog
                        }
                        else
                        {
                          onPositiveButtonClicked();
                        }
                      },
                      child: Text(buttonText,
                        style: TextStyle(
                            fontSize: AppFontSize.size16,
                            color: AppColors.themeColor,
                            fontFamily: AppFonts.AppFont,
                            fontWeight: AppFontsStyle.BOLD),),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
              backgroundColor: AppColors.textFieldBG,
              radius: Consts.avatarRadius,
              child: SvgPicture.asset(image,)
          ),
        ),
      ],
    );
  }

}
class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 50.0;
}