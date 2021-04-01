import 'package:doctor/blocs/BlocProvider.dart';
import 'package:doctor/blocs/NotesBloc.dart';
import 'package:doctor/ui/HomeScreen.dart';
import 'package:doctor/ui/LoginScreen.dart';
import 'package:doctor/ui/SplashScreen.dart';
import 'package:doctor/values/AppSetings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  var app = MaterialApp(
    title: AppString.APP_NAME,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: AppColors.redTxt,
      accentColor: AppColors.redTxt,
      primaryColorLight: AppColors.redTxt,

      // Define the default font family.
      fontFamily: AppFonts.AppFont,
    ),
    // List all of the app's supported locales here
    supportedLocales: [
      Locale('en', 'US'),
      Locale('hi', 'IN'),
    ],
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => SplashScreen(),
      '/login': (context) => LoginScreen(),
      '/home': (context) => HomeScreen(),
    },
  );
  runApp(app);
}
