
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doctor/values/AppSetings.dart';

class HeaderWidgetLight extends StatefulWidget {
  String title;
  String icon;
  bool exitApp=false;
  Color color;
  final Function() onChange;

  HeaderWidgetLight(this.title,{this.icon="images/back_arrow.svg",this.onChange=null,this.exitApp,this.color=AppColors.transparent});

  @override
  State<StatefulWidget> createState() {
    return HeaderViewLight();
  }

}

class HeaderViewLight extends State<HeaderWidgetLight> {
  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Container(
      color: widget.color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: (){
              if(widget.exitApp==null)
              {
                widget.exitApp=false;
              }
//                  widget.onChange();
              widget.onChange==null?
              widget.exitApp?SystemNavigator.pop(animated: true):Navigator.pop(context)
                  :widget.onChange();
            },
            icon: Icon(Icons.arrow_back_ios,size:20 , color: AppColors.white,),
          ),
          SizedBox(width: 10,),
          Expanded(child: Text(
            "${widget.title}",
            maxLines: 2,
            style: TextStyle(
                fontSize: 14.0,
                color: AppColors.white,
                fontFamily: AppFonts.AppFont,
                fontWeight: AppFontsStyle.BOLD),
          ))
        ],
      )
    );
  }
}
