
import 'package:doctor/model/DoctorListResponseModel.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/CommonUIs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doctor/values/AppSetings.dart';

class ContactListItemWidget extends StatefulWidget {
  DoctorListResponseModel doctor;
  final Function() onSelected;

  ContactListItemWidget(this.doctor,{this.onSelected});

  @override
  State<StatefulWidget> createState() {
    return ContactWidget();
  }

}

class ContactWidget extends State<ContactListItemWidget> {
  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ()
      {
        widget.onSelected();
      },
      child: Container(
          margin: EdgeInsets.all(10),
          color: AppColors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(10000.0),
                  child: CommonUis.getCircularImageAvatar(widget.doctor.profile_pic, 50, 50)
              ),
              SizedBox(width: 10,),
              Expanded(child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonUis.getText("${widget.doctor.first_name} ${widget.doctor.last_name}", AppColors.themeColorDark, AppFontSize.size16,weight: AppFontsStyle.BOLD,alignment: TextAlign.start),
                  CommonUis.getText("${widget.doctor.specialization}", AppColors.themeColorDark, AppFontSize.size16,weight: AppFontsStyle.REGULAR),
                  CommonUis.getText("${widget.doctor.description}", AppColors.black, AppFontSize.size14,weight: AppFontsStyle.REGULAR,maxLines: 2),
                ],
              )),
              SizedBox(width: 10,),
              Icon(Icons.arrow_forward_ios,size: 15,color: AppColors.themeColor,),
            ],
          )
      ),
    );
  }
}
