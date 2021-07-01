import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/values/AppSetings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:toast/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtill {
  static printAppLog(String msg) {
    debugPrint(msg, wrapWidth: 1024);
  }

  static void LogPrint(Object object) async {
    int defaultPrintLength = 800;
    if (object == null || object.toString().length <= defaultPrintLength) {
      print(object);
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        print(log.substring(start, endIndex));
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print(log.substring(start, logLength));
      }
    }
  }

  static bool isValid(var str) {
    if (str == null || str.toString().trim().length == 0 || str == "null") {
      return false;
    }
    return true;
  }

  static printClass(classObj) {
    AppUtill.printAppLog('printClass = ${jsonEncode(classObj)}');
  }

  static double getSize(double size, double percent) {
    size = size * percent / 100;
    return size;
  }

  static showToast(String msg, context, {int duration = 3, int? gravity}) {
    // Toast.show(msg, context, duration: duration, gravity: gravity);
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  static Color getColorFromString(String hexString, String opacity) {
    if (hexString.contains("#")) {
      hexString = hexString.replaceAll("#", opacity);
      return Color(int.parse(hexString, radix: 16));
    }
    return AppColors.white;
  }

  static DateTime getDateTimeFromString(String dateStr) {
    DateTime todayDate = DateTime.parse(dateStr);
    return todayDate;
  }

  static int getRandom({int min = 0, int max = 100}) {
    Random rnd;
    rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    print("$r is in the range of $min and $max");
    return r;
  }

  static String ordinalNo(int value) {
    List sufixes = ["th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th"];
    switch (value % 100) {
      case 11:
      case 12:
      case 13:
        return "${value}th";
      default:
        return "${value}${sufixes[value % 10]}";
    }
  }

  static int toInteger(double number) {
    return number.toInt();
  }

  static Widget getImageView(String? url, BoxFit fit,
      {double height = 30, Color? color}) {
    return isValid(url)
        ? url!.contains("data/user")
            ? Image.file(
                File(url),
                height: height,
                fit: BoxFit.fill,
              )
            : CachedNetworkImage(
                imageUrl: url,
                placeholder: (context, url) => Image(
                  image: AssetImage("images/house_leasing.svg"),
                  height: height,
                ),
                errorWidget: (context, url, error) => Image(
                  image: AssetImage("images/house_leasing.svg"),
                  height: height,
                ),
                height: height,
                fit: fit,
                color: color,
              )
        : SvgPicture.asset(
            "images/house_leasing.svg",
            height: height,
            fit: fit,
          );
  }

  static getTrimString(double value) {
    if (value != null) {
      return value.toStringAsFixed(2);
    } else {
      return "${value}";
    }
  }

  static roundOffPrice(var price) {
    if (price == null) {
      price = 0.0;
    }
    if (price is int || price is double) {
      price = price.toString();
    }
    if (price is String) {
      try {
        price = double.parse(price);
      } catch (e) {
        AppUtill.printAppLog(e.toString());
      }
    }
    return price.toStringAsFixed(0);
  }

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static Map<String, String> getQueryParameters(String url) {
    var uri = Uri.dataFromString(url); //converts string to a uri
    Map<String, String> params =
        uri.queryParameters; // query parameters automatically populated
    print(jsonEncode(params));
    return params;
  }

  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  static bool isValidMobileNo(String phoneNo) {
    RegExp validPhoneNumberRegExp = new RegExp(
      r"^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$",
      caseSensitive: false,
      multiLine: false,
    );

    return validPhoneNumberRegExp.hasMatch(phoneNo);
  }

  static bool isValidPanNo(String PANNo) {
    if (PANNo.length == 15) {
      PANNo = PANNo.substring(2, PANNo.length - 3);
    }
    RegExp validPANRegExp = new RegExp(
      r"^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$",
      caseSensitive: false,
      multiLine: false,
    );

    return validPANRegExp.hasMatch(PANNo);
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
