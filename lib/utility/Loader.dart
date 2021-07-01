import 'package:doctor/values/AppSetings.dart';
import 'package:flutter/material.dart';

import 'CommonUIs.dart';
class Loader{

  static OverlayEntry? loader ;

  static showLoader(BuildContext context){
    if (loader != null){ // Loader is already running
      return;
    }
    OverlayState overlayState = Overlay.of(context)!;
    loader = OverlayEntry(builder: (context) => Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: 120,
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10,),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
                  value: null,
                  strokeWidth: 4.0,
                ),
                SizedBox(height: 20,),
                CommonUis.getText("Please Wait...", AppColors.black, 14.0,weight: AppFontsStyle.BOLD)
              ],
            ),
          ),
        ),
      ),
    ));
    overlayState.insert(loader!);
  }
  static hideLoader(){
    if (loader != null){
      loader!.remove();
      loader = null;
    }
  }

}