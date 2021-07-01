
import 'package:doctor/model/DoctorListResponseModel.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/CommonUIs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctor/values/AppSetings.dart';

import 'StarRating.dart';

class CoroselSliderItemWidget extends StatefulWidget {
  DoctorListResponseModel doctor;

  CoroselSliderItemWidget(this.doctor);

  @override
  State<StatefulWidget> createState() {
    return ContactWidget();
  }

}

class ContactWidget extends State<CoroselSliderItemWidget> {
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        color: AppColors.greyBox,
        child: Row(
          children: [
            AppUtill.getImageView(widget.doctor.profile_pic, BoxFit.cover,height: _size.height,),
            SizedBox(width: 10,),
            Expanded(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonUis.getText("${widget.doctor.first_name} ${widget.doctor.last_name}", AppColors.themeColorDark, AppFontSize.size16,weight: AppFontsStyle.BOLD,alignment: TextAlign.start),
                CommonUis.getText("${widget.doctor.specialization}", AppColors.themeColorDark, AppFontSize.size16,weight: AppFontsStyle.REGULAR),
                StarRating(
                  color: AppUtill.colorFromHex(
                      "#FFAB00"),
                  starCount: 5,
                  rating: widget.doctor.rating,
                )



              ],
            )),

          ],
        )
    );
  }
}
