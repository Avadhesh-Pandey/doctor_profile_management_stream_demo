import 'dart:async';

import 'package:doctor/blocs/DoctorDetailsEditBloc.dart';
import 'package:doctor/data/Database.dart';
import 'package:doctor/model/DoctorListResponseModel.dart';
import 'package:doctor/network/Apis.dart';
import 'package:doctor/ui/widgets/CommonWebView.dart';
import 'package:doctor/ui/widgets/HeaderWidgetLight.dart';
import 'package:doctor/utility/AppDialog.dart';
import 'package:doctor/utility/DateTimeConverter.dart';
import 'package:doctor/utility/Loader.dart';
import 'package:doctor/utility/MediaPicker.dart';
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
// import 'package:toast/toast.dart';

class DoctorDetailEditScreen extends StatefulWidget {
  DoctorListResponseModel? _doctor;

  DoctorDetailEditScreen(this._doctor);

  @override
  State<StatefulWidget> createState() {
    return DoctorDetailWidget();
  }
}

class DoctorDetailWidget extends State<DoctorDetailEditScreen> {
  late Size _size;
  late DoctorDetailEditBLOC _bloc;
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String? genderDropDownValue = "Male";
  String? bloodGroupDropDownValue = "B+";

  @override
  void initState() {
    _bloc = DoctorDetailEditBLOC(widget._doctor);
    fNameController.addListener(() {
      onFNameChanged();
    });
    lNameController.addListener(() {
      onLNameChanged();
    });
    heightController.addListener(() {
      onHeightChanged();
    });
    weightController.addListener(() {
      onWeightChanged();
    });

    if (AppUtill.isValid(widget._doctor!.gender)) {
      genderDropDownValue = widget._doctor!.gender;
    }
    onGenderChanged(genderDropDownValue);

    if (AppUtill.isValid(widget._doctor!.blood_group)) {
      bloodGroupDropDownValue = widget._doctor!.blood_group;
    }

    super.initState();
  }

  void onFNameChanged() {
    _bloc.fNameSink.add(fNameController.text);
  }

  void onLNameChanged() {
    _bloc.lNameSink.add(lNameController.text);
  }

  void onGenderChanged(String? value) {
    _bloc.genderSink.add(value);
  }

  void onBloodChanged(String? value) {
    _bloc.bgSink.add(value);
  }

  void onProfileChanged(String value) {
    _bloc.profileSink.add(value);
  }

  void onHeightChanged() {
    _bloc.heightSink.add(heightController.text);
  }

  void onWeightChanged() {
    _bloc.weightSink.add(weightController.text);
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
                      HeaderWidgetLight(
                        "",
                        exitApp: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 40),
                        decoration: CommonUis.getBoxDecorationTopCurved(),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: CommonUis.getText(
                                  "", AppColors.black, AppFontSize.size16,
                                  weight: AppFontsStyle.BOLD),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 15),
                              child: SizedBox(
                                width: 150,
                                height: 30,
                                child: CommonUis.getThemeRaisedButton(
                                    "UPDATE PROFILE", () {
                                  _bloc.updateContactDetails(context);
                                }),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                      color: AppColors.greyBoxLight,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CommonUis.getText("PERSONAL DETAILS",
                                AppColors.black, AppFontSize.size16,
                                weight: AppFontsStyle.BOLD),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          getDetailsTiles("FIRST NAME",
                              widget._doctor!.first_name, fNameController),
                          getDetailsTiles("LAST NAME", widget._doctor!.last_name,
                              lNameController),

                          Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 10),
                            child: CommonUis.getText(
                                "GENDER", AppColors.greyTxt, AppFontSize.size14,
                                weight: AppFontsStyle.REGULAR),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                right: 35, left: 35, bottom: 10),
                            padding: EdgeInsets.only(right: 15, left: 15),
                            height: 40,
                            width: _size.width,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: AppColors.textFieldBG,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                width: 0.5,
                                color: AppColors.black,
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: genderDropDownValue,
                              icon: Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 40,
                                    color: AppColors.themeColor,
                                  ),
                                ),
                                flex: 1,
                              ),
                              iconSize: 20,
                              elevation: 2,
                              style: TextStyle(color: AppColors.themeColor),
                              underline: Container(
                                height: 0,
                                color: Colors.white,
                              ),
                              onChanged: (String? newValue) {
                                onGenderChanged(newValue);
                                setState(() {
                                  genderDropDownValue = newValue;
                                });
                              },
                              items: [
                                "Male",
                                "Female"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: CommonUis.getText(
                                    value,
                                    AppColors.blackTxt,
                                    14.0,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          // getDetailsTiles("GENDER", !AppUtill.isValid(widget._doctor.gender)?"":"${widget._doctor.gender}",genderController),
                          getDetailsTiles("CONTACT NUMBER",
                              "${widget._doctor!.primary_contact_no}", null,
                              readOnly: true),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            child: CommonUis.getText("DATE OF BIRTH",
                                AppColors.greyTxt, AppFontSize.size14,
                                weight: AppFontsStyle.BOLD),
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectDate();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                getSmallTiles(
                                    "DAY",
                                    !AppUtill.isValid(widget._doctor!.dob)
                                        ? "N/A"
                                        : DateTimeConverter.convert(
                                            widget._doctor!.dob,
                                            outputFormat: "dd",
                                            inputFormat: "yyyy-MM-dd"),
                                    Icons.calendar_today),
                                getSmallTiles(
                                    "MONTH",
                                    !AppUtill.isValid(widget._doctor!.dob)
                                        ? "N/A"
                                        : DateTimeConverter.convert(
                                            widget._doctor!.dob,
                                            outputFormat: "MMM",
                                            inputFormat: "yyyy-MM-dd"),
                                    Icons.calendar_today),
                                getSmallTiles(
                                    "YEAR",
                                    !AppUtill.isValid(widget._doctor!.dob)
                                        ? "N/A"
                                        : DateTimeConverter.convert(
                                            widget._doctor!.dob,
                                            outputFormat: "yyyy",
                                            inputFormat: "yyyy-MM-dd"),
                                    Icons.calendar_today),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 10),
                            child: CommonUis.getText("BLOOD GROUP",
                                AppColors.greyTxt, AppFontSize.size14,
                                weight: AppFontsStyle.REGULAR),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                right: 35, left: 35, bottom: 10),
                            padding: EdgeInsets.only(right: 15, left: 15),
                            height: 40,
                            width: _size.width,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: AppColors.textFieldBG,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                width: 0.5,
                                color: AppColors.black,
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: bloodGroupDropDownValue,
                              icon: Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 40,
                                    color: AppColors.themeColor,
                                  ),
                                ),
                                flex: 1,
                              ),
                              iconSize: 20,
                              elevation: 2,
                              style: TextStyle(color: AppColors.themeColor),
                              underline: Container(
                                height: 0,
                                color: Colors.white,
                              ),
                              onChanged: (String? newValue) {
                                onBloodChanged(newValue);
                                setState(() {
                                  bloodGroupDropDownValue = newValue;
                                });
                              },
                              items: [
                                "B+",
                                "B-",
                                "A-",
                                "A+",
                                "AB+",
                                "AB-",
                                "O",
                                "O-"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: CommonUis.getText(
                                    value,
                                    AppColors.blackTxt,
                                    14.0,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          getDetailsTiles(
                              "HEIGHT", widget._doctor!.height, heightController,
                              textInputType: TextInputType.number,
                              maxLength: 3),
                          getDetailsTiles(
                              "WEIGHT", widget._doctor!.weight, weightController,
                              textInputType: TextInputType.number,
                              maxLength: 4),

                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                )
              ],
            ),
            Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () {
                    openImagePicker();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(top: 20),
                        child: AppUtill.isValid(_bloc.profilePicture)
                            ? CommonUis.getCircularImageAvatar(
                                _bloc.profilePicture, 70, 70)
                            : CommonUis.getCircularImageAvatar(
                                widget._doctor!.profile_pic, 70, 70),
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.white60,
                        child: Icon(
                          Icons.edit_outlined,
                          color: AppColors.black,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                )),
          ],
        )),
      ),
    );
  }

  Container getDetailsTiles(
      String title, String? content, TextEditingController? controller,
      {bool readOnly = false,
      TextInputType textInputType = TextInputType.text,
      int maxLength = 50}) {
    if (controller != null) {
      controller.text = content!;
    } else {
      controller = TextEditingController();
      controller.text = content!;
    }
    return Container(
      color: AppColors.white,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonUis.getText("${title}", AppColors.greyTxt, AppFontSize.size14,
              weight: AppFontsStyle.REGULAR),
          SizedBox(
            height: 8,
          ),
          CommonUis.getCommonTextField(
              hint: title,
              controller: controller,
              readOnly: readOnly,
              textInputType: textInputType,
              maxLength: maxLength),
        ],
      ),
    );
  }

  Container getSmallTiles(String title, String content, IconData icon) {
    return Container(
      width: AppUtill.getSize(_size.width, 30),
      color: AppColors.white,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 15,
                color: AppColors.greyTxt,
              ),
              SizedBox(
                width: 5,
              ),
              CommonUis.getText(
                  "${title}", AppColors.greyTxt, AppFontSize.size14,
                  weight: AppFontsStyle.REGULAR),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_drop_down_circle_outlined,
                size: 15,
                color: AppColors.themeColor,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          CommonUis.getText("${content}", AppColors.black, AppFontSize.size14,
              weight: AppFontsStyle.REGULAR),
        ],
      ),
    );
  }

  _selectDate() async {
    DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate;
        var now = DateTime.now();
        var today = new DateTime(now.year, now.month, now.day);
        tempPickedDate = today;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        AppUtill.printAppLog(
                            "pickedDate::::${DateTimeConverter.convert(tempPickedDate.toString(), outputFormat: "yyyy-MM-dd")} / ${tempPickedDate.toString()}");
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null) {
      String d = DateTimeConverter.convert(pickedDate.toString(),
          outputFormat: "yyyy-MM-dd");
      AppUtill.printAppLog("pickedDate::$d / ${pickedDate.toString()}");
      _bloc.dobSink.add(d);
      setState(() {
        widget._doctor!.dob = d;
      });
    }
  }

  Widget getImagePickerWidget(Size size) {
    AppUtill.printAppLog("getImagePickerWidget");
    return Container(
      height: AppUtill.getSize(size.height, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Select Media Source",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: AppFontSize.size16,
                          color: AppColors.blackTxt,
                          fontFamily: AppFonts.AppFont,
                          fontWeight: AppFontsStyle.BOLD)),
                ),
                flex: 1,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                ),
                flex: 0,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: AppUtill.getSize(size.height, 15),
                width: AppUtill.getSize(size.width, 20),
                child: GestureDetector(
                    onTap: () {
                      MediaPicker(MediaSource.GALLERY).getImage(context,
                          (imageFile) {
                        setState(() {
                          AppUtill.printAppLog("lengthSync==" +
                              imageFile!.lengthSync().toString());
                          if (imageFile != null && imageFile.lengthSync() > 0) {
                            AppUtill.printAppLog(
                                "imageFile::${imageFile.path}");
                            onProfileChanged(imageFile.path);
                          }
                        });
                      }, isCroping: true);

                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      "images/gallery.svg",
                      semanticsLabel: 'gallery',
                    )),
              ),
              Container(
                height: AppUtill.getSize(size.height, 15),
                width: AppUtill.getSize(size.width, 20),
                child: GestureDetector(
                    onTap: () {
                      MediaPicker(MediaSource.CAMERA).getImage(context,
                          (imageFile) {
                        setState(() {
                          if (imageFile != null && imageFile.lengthSync() > 0) {
                            AppUtill.printAppLog(
                                "imageFile::${imageFile.path}");
                            onProfileChanged(imageFile.path);
                          }
                        });
                      }, isCroping: true);
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      "images/camera.svg",
                      semanticsLabel: 'camera',
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  void openImagePicker() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return getImagePickerWidget(_size);
        });
  }
}
