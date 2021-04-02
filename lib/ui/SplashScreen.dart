import 'dart:async';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/values/AppPrefs.dart';
import 'package:doctor/values/AppSetings.dart';
import 'package:doctor/values/Keys.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';


class SplashScreen extends StatefulWidget {
  @override
  SplashStateFull createState() => SplashStateFull();
}

class SplashStateFull extends State<SplashScreen> {
  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        color: AppColors.white,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "images/bima_doctor_name_logo.png",
                    width: 300,),
                ),
                Text(
                  "Doctors Profile Management",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: AppColors.themeContrastColor,
                      fontFamily: AppFonts.AppFont,
                      fontWeight: AppFontsStyle.REGULAR),
                )
              ],
            ),
          ],
        )
      ),
    );
  }

  @override
  void initState() {

    AppPrefs.getInstanceFuture((initialised)
    {
      AppUtill.printAppLog("AppPrefs-InstanceFuture");
      if(AppPrefs.getInstance().checkLogin())
    {
      AppUtill.printAppLog("AUTH-TOKEN::"+AppPrefs.getInstance().getStringData(Keys.AUTH_TOCKEN));
    }
    });
    Timer(Duration(seconds: 3), () {
      navigateFurther();
    });
    super.initState();
  }

  void navigateFurther()
  {
    if (AppPrefs.getInstance().checkLogin()) {
      Navigator.pop(context);
      Navigator.of(context).pushNamed('/home');

    } else {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }));

    }
  }

  void dispose() {
    super.dispose();
  }
}
