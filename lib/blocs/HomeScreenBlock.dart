import 'dart:async';

import 'package:doctor/data/Database.dart';
import 'package:doctor/model/DoctorListResponseModel.dart';
import 'package:doctor/process/ContactProcess.dart';
import 'package:doctor/ui/DoctorDetailEditScreen.dart';
import 'package:doctor/utility/AppDialog.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/Loader.dart';
import 'package:flutter/cupertino.dart';

final listStreamCOntroller =
    StreamController<List<DoctorListResponseModel>?>.broadcast();
final carouselSliderStreamController =
    StreamController<List<DoctorListResponseModel>?>.broadcast();

class HomeScreenBlock {
  StreamSink<List<DoctorListResponseModel>?> get listSink =>
      listStreamCOntroller.sink;
  Stream<List<DoctorListResponseModel>?> get listStream =>
      listStreamCOntroller.stream;

  StreamSink<List<DoctorListResponseModel>?> get carouselSliderSink =>
      carouselSliderStreamController.sink;
  Stream<List<DoctorListResponseModel>?> get carouselSliderStream =>
      carouselSliderStreamController.stream;

  getContacts(BuildContext context) {
    DBProvider.db.getNotes().then((value) {
      if (value != null && value.length > 0) {
        AppUtill.showToast("Data Retrieved from Local Database", context);
        AppUtill.printAppLog("DBProvider.db.getNotes.length:: ${value.length}");
        getTopThree();

        listSink.add(value);
      } else {
        Loader.showLoader(context);
        ContactProcess().getAllContacts(
          (apiResponse) {
            Loader.hideLoader();
            if (apiResponse.status!) {
              List<DoctorListResponseModel>? _doctorList =
                  List<DoctorListResponseModel>.filled(
                      0, DoctorListResponseModel(),
                      growable: true);
              AppUtill.printAppLog("apiResponse::::${apiResponse.raw}");
              _doctorList = apiResponse.raw != null
                  ? (apiResponse.raw as List)
                      .map((i) => DoctorListResponseModel.fromJson(i))
                      .toList()
                  : List<DoctorListResponseModel>.filled(
                      0, DoctorListResponseModel(),
                      growable: true);
              ;
              AppUtill.printAppLog("apiResponse::::${_doctorList.length}");

              _doctorList.forEach((element) {
                DBProvider.db.newNote(element);
              });

              DBProvider.db.getNotes().then((value) {
                AppUtill.printAppLog(
                    "DBProvider.db.getNotes.length:: ${value!.length}");
                _doctorList = value;
                listSink.add(_doctorList);
              });

              getTopThree();
            } else {
              AppDialog.showErrorDialog(
                  context, "", apiResponse.msg, apiResponse.statusCode,
                  onRetry: () {
                getContacts(context);
              });
            }
          },
        );
      }
    });
  }

  getTopThree() {
    DBProvider.db.getNoteTopThree().then((valuee) {
      carouselSliderSink.add(valuee);
      AppUtill.printAppLog(
          "DBProvider.db.getNotes.length2:: ${valuee!.length}");
    });
  }
}
