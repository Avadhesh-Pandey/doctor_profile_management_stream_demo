import 'dart:io';

import 'package:doctor/blocs/BlocProvider.dart';
import 'package:doctor/blocs/HomeScreenBlock.dart';
import 'package:doctor/blocs/NotesBloc.dart';
import 'package:doctor/data/Database.dart';
import 'package:doctor/model/DoctorListResponseModel.dart';
import 'package:doctor/process/ContactProcess.dart';
import 'package:doctor/ui/DoctorDetailScreen.dart';
import 'package:doctor/ui/OTPScreen.dart';
import 'package:doctor/ui/widgets/CommonWebView.dart';
import 'package:doctor/ui/widgets/ContactListItemWidget.dart';
import 'package:doctor/ui/widgets/HeaderWidgetLight.dart';
import 'package:doctor/utility/AppDialog.dart';
import 'package:doctor/utility/CustomAlertDialog.dart';
import 'package:doctor/utility/Loader.dart';
import 'package:doctor/values/AppPrefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doctor/network/Apis.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/CommonUIs.dart';
import 'package:doctor/values/AppSetings.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeWidget();
  }
}


class HomeWidget extends State<HomeScreen> {
  Size _size;
  HomeScreenBlock _homeScreenBlock=HomeScreenBlock();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _homeScreenBlock.getContacts(context);
    });
    super.initState();
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
        drawer: Drawer(
          child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset("images/bima_doctor_name_logo.png",fit: BoxFit.fitWidth,),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text('What We Do'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('News and Awards'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Contact Us'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),

            Padding(padding: EdgeInsets.only(top: 20,right: 20,left: 20),child: CommonUis.getThemeRaisedButton("LOGOUT", () {

              CustomAlertDialog.show(context, AppDialog.DIALOG_INFO, "Are you sure you want to logout ? ",
                  title: "",buttonText: "Cancel" ,isNegativeButtonVisible: true,
                  negativeButtonText: "Confirm",
                  onNegativeButtonClicked: ()
                  {
                    AppPrefs.getInstance().setLogout(true);
                    DBProvider.db.deleteAll();
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/login');
                  },
                  /*onPositiveButtonClicked: ()
                      {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return SubmitCannedCodesScreen(scannedCodesList);
                            }));
                      },*/image: "images/info_icon.svg");

            }),)

          ],
        ),
        ),
        backgroundColor: AppColors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.themeColor, //change your color here
          ),
          titleSpacing: 0,
          elevation: 1,
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("images/bima_doctor_name_logo.png",height: 50,),
              Image.asset("images/bima_logo.png",height: 50,fit: BoxFit.fitHeight,),
            ],
          ),
        ),
        body:StreamBuilder(
          stream: _homeScreenBlock.listStream,
          initialData: [],
          builder: (BuildContext context,AsyncSnapshot snapshot)
          {
            return ListView.separated(itemBuilder: (_, index){
              return ContactListItemWidget(snapshot.data[index],onSelected: ()
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return DoctorDetailScreen(snapshot.data[index]);
                    }));
              },);
            }, separatorBuilder: (context, index) => Divider(
            ), itemCount: snapshot.data.length);
          },
        )
      ),

    ), onWillPop: (){
      Navigator.pop(context);
      exit(0);
    });
  }
}

