import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:doctor/values/AppSetings.dart';

class CommonUis
{
  static Widget getText(String text,Color color, double size,{String font=AppFonts.AppFont,TextAlign alignment = TextAlign.start,int maxLines,FontWeight weight = FontWeight.normal,bool addAsterisk=false}) {
    return Text(
      "$text${addAsterisk?"\u002A":""}",
      maxLines: maxLines,
      textAlign: alignment,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color,
          fontFamily: font,
          fontSize: size,
          fontWeight: weight
      ),
    );
  }
    static Container getThemeButton(String text)
  {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: AppColors.white
      ),
      margin: EdgeInsets.only(right: 10, left: 10),
      height: 45.0,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 12.0,
            color: AppColors.black,
            fontFamily: AppFonts.AppFont,
            fontWeight: AppFontsStyle.BOLD),
      )
    );
  }

  static Container getThemeTextField(String text)
  {
    return Container(
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: AppColors.themeColor
        ),
        margin: EdgeInsets.only(right: 10, left: 10),
        height: 40.0,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 12.0,
              color: AppColors.white,
              fontFamily: AppFonts.AppFont,
              fontWeight: AppFontsStyle.REGULAR),
        )
    );
  }
  static Container getThemeRaisedButton(String text,Function() onButtonPressed,{double height=50.0})
  {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      width: double.infinity,
      height: height,
      child: RaisedButton(
          onPressed: () {
            onButtonPressed();
          },
          color: AppColors.themeContrastColorTwo,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)),
          padding: EdgeInsets.all(0.0),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14.0,
                color: AppColors.white,
                fontFamily: AppFonts.AppFont,
                fontWeight: AppFontsStyle.BOLD),
          )),
    );
  }
  static Container getThemeRaisedButtonDisabled(String text,Function() onButtonPressed,{double height=50.0})
  {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      width: double.infinity,
      height: height,
      child: RaisedButton(
          onPressed: () {
            onButtonPressed();
          },
          color: AppColors.themeContrastColorTwo,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)),
          padding: EdgeInsets.all(0.0),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14.0,
                color: AppColors.white60,
                fontFamily: AppFonts.AppFont,
                fontWeight: AppFontsStyle.BOLD),
          )),
    );
  }

  static Container getThemeRaisedButtonNegative(String text,Function() onButtonPressed,{double height=50.0})
  {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: AppColors.white,
        border: Border.all(
        width: 1.0,
        color: AppColors.themeContrastColor,
      ),
      ),

      child: RaisedButton(
          onPressed: () {
            onButtonPressed();
          },
          color: AppColors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)),
          padding: EdgeInsets.all(0.0),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14.0,
                color: AppColors.themeContrastColor,
                fontFamily: AppFonts.AppFont,
                fontWeight: AppFontsStyle.BOLD),
          )),
    );
  }

  static Widget getButton(String text,{Color textColor = AppColors.textColor,String font = AppFonts.AppFont,double fontSize = 16.0,FontWeight fontWeight = FontWeight.normal,Function onButtonPressed,double height = 45.0,double width = double.infinity,Color color = AppColors.themeColor}){
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height/2),
        color: color
      ),

      child: RaisedButton(
          onPressed: () {
            onButtonPressed();
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height/2)
          ),
          color: color,
          child: CommonUis.getText(text, textColor, fontSize, font: font,alignment: TextAlign.center)),
    );
  }


  static Container getCommonTextField({String hint="",String text,TextEditingController controller,TextInputType textInputType=TextInputType.text,int maxLength=null,textCapitalization=TextCapitalization.words,double marginTop=10,bool readOnly=false})
  {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 15, right: 15, top: marginTop,bottom: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: AppColors.white
      ),
      child: Theme(
        data: ThemeData(
            primaryColor: AppColors.black,
            accentColor: AppColors.black,
            hintColor: AppColors.greyTxt),
        child:
        TextField(
          autofocus: false,
          readOnly: readOnly,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            hintText: hint,
            labelText: text,
            counterText: "",
            contentPadding: EdgeInsets.only(left: 12, bottom: 12,top: 12),
            hintStyle: new TextStyle(color: AppColors.greyTxt),
            labelStyle: new TextStyle(
                color: AppColors.divider,
              fontFamily: AppFonts.AppFont,
              fontWeight: AppFontsStyle.REGULAR,),
          ),
          textCapitalization: textCapitalization,
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.blackTxt,
            fontFamily: AppFonts.AppFont,
            fontWeight: AppFontsStyle.REGULAR,
          ),
          maxLines: 1,
          maxLength: maxLength,
          controller: controller,
          keyboardType: textInputType,
        ),
      ),
    );
  }

  static Container getCommonTextFieldWithHeader({String hint="",String text,TextEditingController controller,TextInputType textInputType=TextInputType.text,int maxLength=null,textCapitalization=TextCapitalization.words})
  {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: AppColors.transparent
      ),
      child: Theme(
        data: ThemeData(
            primaryColor: AppColors.black,
            accentColor: AppColors.black,
            hintColor: AppColors.greyTxt),
        child:
        TextField(
          autofocus: false,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            hintText: hint,
            labelText: text,
            counterText: "",
            contentPadding: EdgeInsets.only(left: 30, bottom: 15,top: 20),
            hintStyle: new TextStyle(color: AppColors.greyTxt),
            labelStyle: new TextStyle(
              color: AppColors.blackTxt,
              fontFamily: AppFonts.AppFont,
              fontWeight: AppFontsStyle.REGULAR,),
          ),
          textCapitalization: textCapitalization,
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.blackTxt,
            fontFamily: AppFonts.AppFont,
            fontWeight: AppFontsStyle.REGULAR,
          ),
          maxLines: 1,

          maxLength: maxLength,
          controller: controller,
          keyboardType: textInputType,
        ),
      ),
    );
  }

  static BoxDecoration getBoxDecorationTopCurved()
  {
    return BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),),
      color: AppColors.white,
      border: Border.all(
        width: 0.0,
        color: AppColors.white,
      ),

    );
  }

  static getCircularImageAvatar(String imageUrl,double height,double width,{IconData icon=Icons.person})
  {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10000.0),
      child: CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: imageUrl==null?"":imageUrl,
        placeholder: (context, url) =>
            CircleAvatar(
              radius: height/2,
              backgroundColor: AppColors.white,
              child: Icon(icon,color: AppColors.themeColor,),
            ),
        errorWidget: (context, url, error) =>
            CircleAvatar(
              radius: height/2,
              backgroundColor: AppColors.white,
              child: Icon(icon,color: AppColors.themeColor,),
            ),
      ),
    );
  }

  static getGradientColor()
  {
    return [
      const Color(0x501976D2),
      const Color(0xFF1976D2),
      const Color(0xFF2196F3)
    ];
  }

  static getGradientColorBlue()
  {
    return [
      const Color(0xFFCDD5EF),
      const Color(0xFFC6DCF3),
      const Color(0xFFADF0FF)
    ];
  }

}